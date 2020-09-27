import Foundation
import SwiftyJSON

protocol APIRequest {
    associatedtype APIResponse

    var method: HTTPMethod { get }
    var isRequiredAuthentication: Bool { get }
    var path: String { get }
    var parameters: [String: Any] { get }

    func apiResponse(from data: Data?) -> APIResponse
}
