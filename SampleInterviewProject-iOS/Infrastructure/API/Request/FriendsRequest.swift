//
//  FriendRequest.swift
//  SampleInterviewProject-iOS
//
//  Created by Joy Marie Navales on 9/26/20.
//  Copyright © 2020 Joy Marie Navales. All rights reserved.
//

import Foundation

struct FriendsRequest: APIRequest {
    let method = HTTPMethod.get
    let isRequiredAuthentication = true
    let path = "/friends"
    let parameters: [String: Any] = [:]

    func apiResponse(from data: Data?) -> FriendsResponse {
        return FriendsResponse(data: data!)
    }
}
