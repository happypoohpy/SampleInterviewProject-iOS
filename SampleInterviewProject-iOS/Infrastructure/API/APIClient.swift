import Foundation
import RxSwift

struct APIClient {

    static let shared = APIClient(
        configuration: Configuration.shared,
        middlewares: [
            ActivityCountMiddleware(),
        ]
    )

    // MARK: - Property

    private let configuration: Configuration
    private let middlewares: [APIMiddleware]
    private let urlSession: URLSession

    private var commonHeader: [String: String] {
        var header = [String: String]()
        header["Accept"] = "application/json"

        if Configuration.shared.apiBasicAuthRequired {
            let user = Configuration.shared.apiBasicAuthUser
            let password = Configuration.shared.apiBasicAuthPassword
            let basicAuthToken = "\(user):\(password)".data(using: .utf8)!.base64EncodedString(options: [])
            header["Authorization"] = "Basic \(basicAuthToken)"
        }

        return header
    }

    // MARK: - Initializer

    init(configuration: Configuration, middlewares: [APIMiddleware] = []) {
        self.configuration = configuration
        self.middlewares = middlewares
        let configuration = URLSessionConfiguration.default
        configuration.httpMaximumConnectionsPerHost = 1
        self.urlSession = URLSession(configuration: configuration)
    }

    init() {
        self.init(configuration: Configuration.shared)
    }

    // MARK: - Public

    func send<T: APIRequest>(_ request: T) -> Single<T.APIResponse> {
        return prepares(request)
            .flatMap { self.sendSession(request) }
            .catchError { self.recovers(request, error: $0) }
            .flatMap { self.apiResponse(request, response: $0) }
            .asSingle()
    }
}

extension APIClient {
    enum Error: Swift.Error, Equatable {
        case invalidURLComponents
        case noURLResponse
        case nonHTTPResponse(urlResponse: URLResponse)
        case errorResponseRequired
        case unauthorized
        case maintenance

        static func == (lhs: Error, rhs: Error) -> Bool {
            switch (lhs, rhs) {
            case (.invalidURLComponents, .invalidURLComponents):
                return true
            case (.noURLResponse, .noURLResponse):
                return true
            case let (.nonHTTPResponse(lhs), .nonHTTPResponse(rhs)) where lhs == rhs:
                return true
            case (.errorResponseRequired, .errorResponseRequired):
                return true
            case (.unauthorized, .unauthorized):
                return true
            case (.maintenance, .maintenance):
                return true
            default:
                return false
            }
        }
    }
}

extension APIClient {
    private func prepares<T: APIRequest>(_ request: T) -> Observable<Void> {
        return middlewares.reversed().reduce(.just(())) { result, middleware in
            result.flatMap { middleware.prepare(request, with: self) }
        }
    }

    private func sendSession<T: APIRequest>(_ request: T) -> Observable<T.APIResponse> {
        var urlRequest: URLRequest
        do {
            urlRequest = try self.urlRequest(from: request)
        } catch {
            return .error(error)
        }

        return Observable<T.APIResponse>.create { observer in
            self.task(urlRequest: urlRequest, request: request, observer: observer)
        }
    }

    private func task<T: APIRequest>(urlRequest: URLRequest, request: T, observer: AnyObserver<T.APIResponse>)
        -> Disposable {
        let task = urlSession.dataTask(with: urlRequest) { data, urlResponse, error in
            guard let urlResponse = urlResponse else {
                observer.onError(error ?? Error.noURLResponse)
                return
            }

            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                observer.onError(Error.nonHTTPResponse(urlResponse: urlResponse))
                return
            }

            var responseData = data
            do {
                responseData = try self.middlewares.reversed().reduce(responseData) { data, middleware in
                    try middleware.responseData(request, from: httpResponse, with: data)
                }
            } catch {
                observer.onError(error)
                return
            }

            let apiResponse = request.apiResponse(from: responseData)
            observer.onNext(apiResponse)
            observer.onCompleted()
        }

        task.resume()
        return Disposables.create(with: task.cancel)
    }

    private func urlRequest<T: APIRequest>(from apiRequest: T) throws -> URLRequest {
        let url = try self.url(from: apiRequest)
        var urlRequest = URLRequest(url: url)
        var header = commonHeader

        if apiRequest.method == .post || apiRequest.method == .put || apiRequest.method == .delete {
            let json = try JSONSerialization.data(withJSONObject: apiRequest.parameters, options: [])
            urlRequest.httpBody = json
            header["Content-Type"] = "application/json; charset=utf-8"
            header["Content-Length"] = "\(json.count)"
        }

        urlRequest.allHTTPHeaderFields = header
        urlRequest.httpMethod = apiRequest.method.rawValue

        urlRequest = try middlewares.reduce(urlRequest) { request, middleware in
            try middleware.request(apiRequest, from: request)
        }

        return urlRequest
    }

    private func url<T: APIRequest>(from apiRequest: T) throws -> URL {
        var components = URLComponents()
        components.scheme = configuration.apiScheme
        components.host = configuration.apiHost
        components.path = apiRequest.path

        if apiRequest.method == .get {
            components.queryItems = queryItems(from: apiRequest)
        }

        guard let url = components.url else {
            throw Error.invalidURLComponents
        }

        return url
    }

    private func queryItems<T: APIRequest>(from apiRequest: T) -> [URLQueryItem] {
        let queryItems = [URLQueryItem]()
        return apiRequest.parameters.reduce(queryItems) { result, parameter in
            let value = parameter.value as? String ?? "\(parameter.value)"
            let queryItem = URLQueryItem(name: parameter.key, value: value)
            return result + [queryItem]
        }
    }

    private func apiResponse<T: APIRequest>(_ request: T, response: T.APIResponse) -> Observable<T.APIResponse> {
        return middlewares.reversed().reduce(.just(response)) { result, middleware in
            result.flatMap { middleware.apiResponse(request, from: $0) }
        }
    }

    private func recovers<T: APIRequest>(_ request: T, error: Swift.Error) -> Observable<T.APIResponse> {
        return middlewares.reversed().reduce(.error(error)) { result, middleware in
            result.catchError { middleware.recover(request, from: $0) }
        }
    }
}
