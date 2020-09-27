import Foundation
import RxSwift

struct ActivityCountMiddleware: APIMiddleware {

    func request<T: APIRequest>(_ request: T, from urlRequest: URLRequest) throws -> URLRequest {
        NetworkActivityManager.shared.didResume()
        return urlRequest
    }

    func responseData<T>(_ request: T, from urlResponse: HTTPURLResponse, with data: Data?)
        throws -> Data? where T: APIRequest {
        NetworkActivityManager.shared.didComplete()
        return data
    }

    func recover<T: APIRequest>(_ request: T, from error: Error) -> Observable<T.APIResponse> {
        NetworkActivityManager.shared.didComplete()
        return .error(error)
    }
}
