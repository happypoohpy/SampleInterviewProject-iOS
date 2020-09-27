//
//  ProfileViewController.swift
//  SampleInterviewProject-iOS
//
//  Created by Joy Marie Navales on 9/26/20.
//  Copyright © 2020 Joy Marie Navales. All rights reserved.
//

import UIKit
import Kingfisher

protocol ProfileView: class {
    func displayProfile(profile: User)
}

class ProfileViewController: UIViewController {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var featuredFriendsCollectionView: UICollectionView!
    @IBOutlet weak var shotsCollectionView: UICollectionView!
    @IBOutlet weak var shotsCollectionViewHeight: NSLayoutConstraint!
    
    private lazy var presenter: ProfilePresenter = ProfileViewPresenter.init(view: self)
    
    private lazy var featuredFriendsDataSource: FeaturedFriendsDataSource = .init(presenter: presenter)
    private lazy var shotsDataSource: ShotsDataSource = .init(presenter: presenter)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.title = "Profile"
        
        setupCollections()
        presenter.onViewLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.navigationItem.title = "Profile"
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        navigationItem.title = "Profile"
    }
    
    private func setupCollections() {
        featuredFriendsDataSource.bindCollectionView(collectionView: featuredFriendsCollectionView)
        shotsDataSource.bindCollectionView(collectionView: shotsCollectionView)
    }
    
    @IBAction func displayMoreActionSheet(_ sender: Any) {
        
        let optionMenu = UIAlertController(title: nil, message: "More", preferredStyle: .actionSheet)
            
        let moreAction = UIAlertAction.init(title: "About", style: .default, handler: { action in
            
            self.showAboutScreen()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            
        optionMenu.addAction(moreAction)
        optionMenu.addAction(cancelAction)
            
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func showAboutScreen() {
        self.performSegue(withIdentifier: "showAboutModally", sender: self)
    }
}

extension ProfileViewController : ProfileView {
    
    func displayProfile(profile: User) {
        if let avatarUrl = profile.avatarUrl {
            let url = URL.init(string: avatarUrl)
            avatarImageView.sample.makeRounded()
                .kf.setImage(with: url)
        }
        if let givenName = profile.givenName,
            let surname = profile.surname {
            nameLabel.text = "\(givenName) \(surname)"
        }
        locationLabel.text = profile.location
        aboutLabel.text = profile.about
        featuredFriendsCollectionView.reloadData()
        shotsCollectionView.reloadData()
        shotsCollectionViewHeight.constant = shotsCollectionView.collectionViewLayout.collectionViewContentSize.height
        self.view.layoutIfNeeded()
    }
}

// MARK: - StoryboardInstantiatable

extension ProfileViewController: StoryboardInstantiatable {
    static let storyboardName = "Main"
}
