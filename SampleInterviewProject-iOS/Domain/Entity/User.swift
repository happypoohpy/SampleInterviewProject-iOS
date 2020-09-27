//
//  User.swift
//  SampleInterviewProject-iOS
//
//  Created by Joy Marie Navales on 9/26/20.
//  Copyright © 2020 Joy Marie Navales. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
    let id: UInt64?
    let givenName: String?
    let surname: String?
    let location: String?
    let about: String?
    let avatarUrl: String?
    let featuredFriends: [Friend]?
    let shots: [Shot]?
}

// MARK: - JSONDecodable

extension User: JSONDecodable {
    static func decode(_ json: JSON) -> User {
        return User(
            id: json["id"].uInt64,
            givenName: json["givenName"].stringValue,
            surname: json["surname"].stringValue,
            location: json["location"].stringValue,
            about: json["about"].stringValue,
            avatarUrl: json["avatarUrl"].stringValue,
            featuredFriends: [Friend].decode(json["featuredFriends"].arrayValue),
            shots: [Shot].decode(json["shots"].arrayValue)
        )
    }
}
