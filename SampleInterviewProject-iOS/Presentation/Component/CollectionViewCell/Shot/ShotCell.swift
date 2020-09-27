//
//  ShotCell.swift
//  SampleInterviewProject-iOS
//
//  Created by Joy Marie Navales on 9/26/20.
//  Copyright © 2020 Joy Marie Navales. All rights reserved.
//

import UIKit

class ShotCell: UICollectionViewCell {
    
    @IBOutlet weak var imageImageView: UIImageView!
}

extension ShotCell {
    
    func setupShot(_ shot: Shot){
        if let imageUrl = shot.imageUrl {
            let url = URL.init(string: imageUrl)
            self.imageImageView.kf.setImage(with: url)
        }
    }
}

// MARK: - ReusableDequeueable

extension ShotCell: ReusableDequeueable {
    static let identifier = "ShotCell"
}

