//
//  UIFont+Sample.swift
//  SampleInterviewProject-iOS
//
//  Created by Joy Marie Navales on 9/27/20.
//  Copyright © 2020 Joy Marie Navales. All rights reserved.
//

import Foundation
import UIKit

extension SampleExtension where Base: UIFont {
    
    static func openSansBold(size: CGFloat) -> UIFont? {
        return UIFont(name: "OpenSans-Bold", size:size)
    }
    
    static func openSansRegular(size: CGFloat) -> UIFont? {
        return UIFont(name: "OpenSans-Regular", size:size)
    }
}
