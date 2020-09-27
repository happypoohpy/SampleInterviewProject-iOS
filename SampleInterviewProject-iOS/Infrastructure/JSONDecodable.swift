import Foundation
import SwiftyJSON

protocol JSONDecodable {
    static func decode(_ json: JSON) -> Self
    static func deserialize(_ data: Data) throws -> Self
}

extension JSONDecodable {
    static func deserialize(_ data: Data) throws -> Self {
        let json = try JSON(data: data)
        return decode(json)
    }
}

extension Array where Element: JSONDecodable {
    static func decode(_ json: [JSON]) -> [Element] {
        return json.map(Element.decode)
    }
}
