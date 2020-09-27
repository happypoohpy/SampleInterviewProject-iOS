//
//  ShotsDataSource.swift
//  SampleInterviewProject-iOS
//
//  Created by Joy Marie Navales on 9/26/20.
//  Copyright © 2020 Joy Marie Navales. All rights reserved.
//

import UIKit

class ShotsDataSource : NSObject {
    fileprivate let presenter: ProfilePresenter
    
    init(presenter: ProfilePresenter) {
        self.presenter = presenter
    }
    
    func bindCollectionView(collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "ShotCell", bundle: nil),
                                forCellWithReuseIdentifier: ShotCell.identifier)
    }
}

extension ShotsDataSource : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
}

extension ShotsDataSource : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 3 - Constants.SHOTS_SPACE
        return CGSize.init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.SHOTS_SPACE
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.SHOTS_SPACE
    }
}

extension ShotsDataSource : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfShots()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let shot = self.presenter.getShots()[indexPath.item]
        
        let cell = collectionView.sample.dequeueReusableCell(ShotCell.self, for: indexPath)
        cell.setupShot(shot)
        
        return cell
    }
    
}

