import Foundation
import RxSwift

protocol APIMiddleware {
    func prepare<T: APIRequest>(_ request: T, with client: APIClient) -> Observable<Void>
    func request<T: APIRequest>(_ request: T, from urlRequest: URLRequest) throws -> URLRequest
    func responseData<T: APIRequest>(_ request: T, from urlResponse: HTTPURLResponse, with data: Data?) throws
        -> Data?
    func recover<T: APIRequest>(_ request: T, from error: Error) -> Observable<T.APIResponse>
    func apiResponse<T: APIRequest>(_ request: T, from apiResponse: T.APIResponse) -> Observable<T.APIResponse>
}

extension APIMiddleware {

    func prepare<T: APIRequest>(_ request: T, with client: APIClient) -> Observable<Void> {
        return .just(())
    }

    func request<T: APIRequest>(_ request: T, from urlRequest: URLRequest) throws -> URLRequest {
        return urlRequest
    }

    func responseData<T: APIRequest>(_ request: T, from urlResponse: HTTPURLResponse, with data: Data?) throws
        -> Data? {
        return data
    }

    func recover<T: APIRequest>(_ request: T, from error: Error) -> Observable<T.APIResponse> {
        return .error(error)
    }

    func apiResponse<T: APIRequest>(_ request: T, from apiResponse: T.APIResponse) -> Observable<T.APIResponse> {
        return .just(apiResponse)
    }
}
