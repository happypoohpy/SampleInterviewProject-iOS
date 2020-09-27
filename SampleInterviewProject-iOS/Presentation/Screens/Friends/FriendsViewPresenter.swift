//
//  FriendsPresenter.swift
//  SampleInterviewProject-iOS
//
//  Created by Joy Marie Navales on 9/26/20.
//  Copyright © 2020 Joy Marie Navales. All rights reserved.
//

import Foundation
import RxSwift

protocol FriendsPresenter : class {
    
    func onViewLoaded()
    func numberOfFriends() -> Int
    func getFriends() -> [Friend]
}

final class FriendsViewPresenter : NSObject {
    private weak var view: FriendsView?
    private var friends: [Friend]?
    private let friendRepository: FriendRepository = FriendRepository()
    let disposeBag = DisposeBag()
    
    init(view: FriendsView) {
        super.init()
        self.view = view
    }
    
    private func retrieveFriends() {
        friendRepository.find()
        .observeOn(MainScheduler.instance)
        .subscribe(onSuccess: { [weak self] friends in
            guard let weakSelf = self else { return }
            
            weakSelf.friends = friends
            weakSelf.view?.refreshList()
        }, onError: { [weak self] error in
        })
        .disposed(by: disposeBag)
    }
}

extension FriendsViewPresenter : FriendsPresenter {
    func onViewLoaded() {
        self.retrieveFriends()
    }
    
    func numberOfFriends() -> Int {
        guard let count = self.friends?.count else {
            return 0
        }
        return count
    }
    
    func getFriends() -> [Friend] {
        guard let shots = self.friends else {
            return []
        }
        return shots
    }
    
    
    
}
