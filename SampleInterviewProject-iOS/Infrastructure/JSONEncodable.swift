import Foundation
import SwiftyJSON

protocol JSONEncodable {
    static func encode(_ c: Self) -> JSON
    static func serialize(_ c: Self) throws -> Data
}

extension JSONEncodable {
    static func serialize(_ c: Self) throws -> Data {
        return try encode(c).rawData()
    }
}

extension Array where Element: JSONEncodable {
    static func encode(_ c: [Element]) -> JSON {
        return JSON(c.map { Element.encode($0) })
    }
}
