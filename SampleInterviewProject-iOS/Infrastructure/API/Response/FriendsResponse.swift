//
//  FriendsResponse.swift
//  SampleInterviewProject-iOS
//
//  Created by Joy Marie Navales on 9/26/20.
//  Copyright © 2020 Joy Marie Navales. All rights reserved.
//

import Foundation
import SwiftyJSON

struct FriendsResponse {
    let friends: [Friend]

    init(data: Data) {
        let json = JSON(data)
        friends = [Friend].decode(json.arrayValue)
    }
}
