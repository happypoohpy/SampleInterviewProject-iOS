//
//  ProfilePresenter.swift
//  SampleInterviewProject-iOS
//
//  Created by Joy Marie Navales on 9/26/20.
//  Copyright © 2020 Joy Marie Navales. All rights reserved.
//

import Foundation
import RxSwift

protocol ProfilePresenter : class {
    func onViewLoaded()
    func numberOfFeaturedFriends() -> Int
    func getFeaturedFriends() -> [Friend]
    func numberOfShots() -> Int
    func getShots() ->[Shot]
}

final class ProfileViewPresenter : NSObject {
    private weak var view: ProfileView?
    private var user: User?
    private let profileRepository: ProfileRepository = ProfileRepository()
    let disposeBag = DisposeBag()
    
    init(view: ProfileView) {
        super.init()
        self.view = view
    }
    
    private func retrieveProfile() {
        profileRepository.find()
        .observeOn(MainScheduler.instance)
        .subscribe(onSuccess: { [weak self] user in
            guard let weakSelf = self else { return }
            
            weakSelf.user = user
            weakSelf.view?.displayProfile(profile: user)
        }, onError: { [weak self] error in
        })
        .disposed(by: disposeBag)
    }
}

extension ProfileViewPresenter : ProfilePresenter {
    func onViewLoaded() {
        retrieveProfile()
    }
    
    func numberOfFeaturedFriends() -> Int {
        guard let count = self.user?.featuredFriends?.count else {
            return 0
        }
        return count
    }
    
    func getFeaturedFriends() -> [Friend] {
        guard let featuredFriends = self.user?.featuredFriends else {
            return []
        }
        return featuredFriends
    }
    
    func numberOfShots() -> Int {
        guard let count = self.user?.shots?.count else {
            return 0
        }
        return count
    }
    
    func getShots() -> [Shot] {
        guard let shots = self.user?.shots else {
            return []
        }
        return shots
    }
}
