//
//  ProfileResponse.swift
//  SampleInterviewProject-iOS
//
//  Created by Joy Marie Navales on 9/26/20.
//  Copyright © 2020 Joy Marie Navales. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ProfileResponse {
    let profile: User

    init(data: Data) {
        let json = JSON(data)
        profile = User.decode(json)
    }
}
