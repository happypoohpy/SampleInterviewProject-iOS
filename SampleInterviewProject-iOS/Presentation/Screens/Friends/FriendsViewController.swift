//
//  FriendsViewController.swift
//  SampleInterviewProject-iOS
//
//  Created by Joy Marie Navales on 9/26/20.
//  Copyright © 2020 Joy Marie Navales. All rights reserved.
//

import UIKit

protocol FriendsView: class {
    func refreshList()
}

class FriendsViewController: UIViewController {

    @IBOutlet weak var friendsTableView: UITableView!
    
    private lazy var presenter: FriendsPresenter = FriendsViewPresenter.init(view: self)
    
    private lazy var friendsDataSource: FriendsDataSource = .init(presenter: presenter)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        presenter.onViewLoaded()
    }
    
    private func setupTableView() {
        self.friendsDataSource.bindTableView(tableView: self.friendsTableView)
    }
    
    @IBAction func tapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension FriendsViewController : FriendsView {
    
    func refreshList() {
        self.friendsTableView.reloadData()
    }
}

// MARK: - StoryboardInstantiatable

extension FriendsViewController: StoryboardInstantiatable {
    static let storyboardName = "Friends"
}
