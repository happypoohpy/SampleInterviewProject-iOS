//
//  FeaturedFriendsDataSource.swift
//  SampleInterviewProject-iOS
//
//  Created by Joy Marie Navales on 9/26/20.
//  Copyright © 2020 Joy Marie Navales. All rights reserved.
//

import UIKit

class FeaturedFriendsDataSource : NSObject {
    fileprivate let presenter: ProfilePresenter
    
    init(presenter: ProfilePresenter) {
        self.presenter = presenter
    }
    
    func bindCollectionView(collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "FeaturedFriendCell", bundle: nil),
                                forCellWithReuseIdentifier: FeaturedFriendCell.identifier)
        
        setCollectionAsSingleRowHorizontal(collectionView)
    }
    
    func setCollectionAsSingleRowHorizontal(_ collectionView: UICollectionView){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3)
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
        flowLayout.scrollDirection = .horizontal
        
        collectionView.collectionViewLayout = flowLayout
    }
}

extension FeaturedFriendsDataSource : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {        
    }
    
}

extension FeaturedFriendsDataSource : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: Constants.FEATURED_FRIENDS_ITEM_WIDTH, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.FEATURED_FRIENDS_ITEM_SPACE
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.FEATURED_FRIENDS_ITEM_SPACE
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let space = Constants.FEATURED_FRIENDS_ITEM_SPACE
        return UIEdgeInsets.init(top: 0, left: space, bottom: 0, right: space)
    }
}

extension FeaturedFriendsDataSource : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfFeaturedFriends()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let friend = self.presenter.getFeaturedFriends()[indexPath.item]
        
        let cell = collectionView.sample.dequeueReusableCell(FeaturedFriendCell.self, for: indexPath)
        cell.setupFeaturedFriend(friend)
        
        return cell
    }
    
}
