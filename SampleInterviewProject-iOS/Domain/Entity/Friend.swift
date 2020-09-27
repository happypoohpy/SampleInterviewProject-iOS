//
//  Friend.swift
//  SampleInterviewProject-iOS
//
//  Created by Joy Marie Navales on 9/26/20.
//  Copyright © 2020 Joy Marie Navales. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Friend {
    let id: UInt64?
    let givenName: String?
    let surname: String?
    let avatarUrl: String?
    let isFavorite: Bool?
}

// MARK: - JSONDecodable

extension Friend: JSONDecodable {
    static func decode(_ json: JSON) -> Friend {
        return Friend(
            id: json["id"].uInt64,
            givenName: json["givenName"].stringValue,
            surname: json["surname"].stringValue,
            avatarUrl: json["avatarUrl"].stringValue,
            isFavorite: json["isFavorite"].boolValue
        )
    }
}

