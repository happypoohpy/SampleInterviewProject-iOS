//
//  AboutPresenter.swift
//  SampleInterviewProject-iOS
//
//  Created by Joy Marie Navales on 9/26/20.
//  Copyright © 2020 Joy Marie Navales. All rights reserved.
//

import Foundation

protocol AboutPresenter : class {
    func onViewLoaded()
}

final class AboutViewPresenter : NSObject {
    private weak var view: AboutView?
    
    init(view: AboutView) {
        super.init()
        self.view = view
    }
}

extension AboutViewPresenter : AboutPresenter {
    func onViewLoaded() {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            view?.displayVersion(version: version)
        }
    }
}
