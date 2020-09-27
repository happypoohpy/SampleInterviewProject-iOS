//
//  FriendRepository.swift
//  SampleInterviewProject-iOS
//
//  Created by Joy Marie Navales on 9/26/20.
//  Copyright © 2020 Joy Marie Navales. All rights reserved.
//

import Foundation
import RxSwift

struct FriendRepository {

    // MARK: - Property
    
    private let apiClient = APIClient.shared

    // MARK: - Public
    
    func find() -> Single<[Friend]> {
        let request = FriendsRequest()
        return apiClient.send(request).map { $0.friends }
    }
}
