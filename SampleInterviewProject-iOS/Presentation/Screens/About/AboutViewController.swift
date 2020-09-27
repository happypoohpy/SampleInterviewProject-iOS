//
//  AboutViewController.swift
//  SampleInterviewProject-iOS
//
//  Created by Joy Marie Navales on 9/26/20.
//  Copyright © 2020 Joy Marie Navales. All rights reserved.
//

import UIKit

protocol AboutView: class {
    func displayVersion(version: String)
}

class AboutViewController: UIViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    
    private lazy var presenter: AboutPresenter = AboutViewPresenter.init(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        presenter.onViewLoaded()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor.sample.black
    }
    
    @IBAction func tapClose(_ sender: Any) {
        self.handleModalViewClose(sender: sender as! UIBarButtonItem)
    }
}

extension AboutViewController : AboutView {
    func displayVersion(version: String) {
        versionLabel.text = "Version \(version)"
    }
}

// MARK: - StoryboardInstantiatable

extension AboutViewController: StoryboardInstantiatable {
    static let storyboardName = "About"
}
