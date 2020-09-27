//
//  UIImageView+Sample.swift
//  SampleInterviewProject-iOS
//
//  Created by Joy Marie Navales on 9/26/20.
//  Copyright © 2020 Joy Marie Navales. All rights reserved.
//

import UIKit

extension SampleExtension where Base : UIImageView {

    func makeRounded(borderWidth : CGFloat = 1.0, bordercolor : CGColor = UIColor.black.cgColor) -> UIImageView {

        base.layer.borderWidth = borderWidth
        base.layer.masksToBounds = false
        base.layer.borderColor = bordercolor
        base.layer.cornerRadius = base.frame.height / 2
        base.clipsToBounds = true
        return base
    }
}
