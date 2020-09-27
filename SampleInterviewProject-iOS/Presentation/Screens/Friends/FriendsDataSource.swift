//
//  FriendsDataSource.swift
//  SampleInterviewProject-iOS
//
//  Created by Joy Marie Navales on 9/26/20.
//  Copyright © 2020 Joy Marie Navales. All rights reserved.
//

import UIKit

class FriendsDataSource : NSObject {
    fileprivate let presenter: FriendsPresenter
    
    init(presenter: FriendsPresenter) {
        self.presenter = presenter
    }
    
    func bindTableView(tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        
        tableView.register(UINib(nibName: "FriendCell", bundle: nil), forCellReuseIdentifier: FriendCell.identifier)
        tableView.register(UINib(nibName: "FavoriteFriendCell", bundle: nil), forCellReuseIdentifier: FavoriteFriendCell.identifier)
    }
}

extension FriendsDataSource : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension FriendsDataSource : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOfFriends()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friend = self.presenter.getFriends()[indexPath.item]
        
        if friend.isFavorite == true {
            let cell = tableView.sample.dequeueReusableCell(FavoriteFriendCell.self, for: indexPath)
            cell.setupFavoriteFriend(friend)
            return cell
        }
        
        let cell = tableView.sample.dequeueReusableCell(FriendCell.self, for: indexPath)
        cell.setupFriend(friend)
        return cell
    }
}

