//
//  Shot.swift
//  SampleInterviewProject-iOS
//
//  Created by Joy Marie Navales on 9/26/20.
//  Copyright © 2020 Joy Marie Navales. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Shot {
    let id: UInt64?
    let imageUrl: String?
}

// MARK: - JSONDecodable

extension Shot: JSONDecodable {
    static func decode(_ json: JSON) -> Shot {
        return Shot(
            id: json["id"].uInt64,
            imageUrl: json["imageUrl"].stringValue
        )
    }
}
