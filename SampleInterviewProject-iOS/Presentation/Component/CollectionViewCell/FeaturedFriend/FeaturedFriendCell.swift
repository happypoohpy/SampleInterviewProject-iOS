//
//  FeaturedFriendCell.swift
//  SampleInterviewProject-iOS
//
//  Created by Joy Marie Navales on 9/26/20.
//  Copyright © 2020 Joy Marie Navales. All rights reserved.
//

import UIKit

class FeaturedFriendCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var givenNameLabel: UILabel!
}

extension FeaturedFriendCell {
    
    func setupFeaturedFriend(_ friend: Friend){
        if let avatarUrl = friend.avatarUrl {
            let url = URL.init(string: avatarUrl)
            let borderColor = friend.isFavorite == true ? UIColor.sample.yellow : UIColor.sample.white
            avatarImageView.kf.setImage(with: url) {
                    result in
                    switch result {
                    case .success( _):
                        _ = self.avatarImageView.sample
                            .makeRounded(borderWidth: Constants.AVATAR_BORDER_WIDTH, bordercolor: borderColor.cgColor)
                    case .failure(let error):
                        print("Job failed: \(error.localizedDescription)")
                    }
                }
        }
        givenNameLabel.text = friend.givenName
    }
}

// MARK: - ReusableDequeueable

extension FeaturedFriendCell: ReusableDequeueable {
    static let identifier = "FeaturedFriendCell"
}
