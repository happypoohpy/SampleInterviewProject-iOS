import Foundation
import SwiftyJSON

struct ErrorResponse: Error {
    let code: Int
    let message: String
}

// MARK: - JSONDecodable

extension ErrorResponse: JSONDecodable {
    static func decode(_ json: JSON) -> ErrorResponse {
        return ErrorResponse(
            code: json["code"].intValue,
            message: json["message"].stringValue
        )
    }
}

// MARK: - Equatable

extension ErrorResponse: Equatable {
    static func == (lhs: ErrorResponse, rhs: ErrorResponse) -> Bool {
        return lhs.code == rhs.code
    }
}
