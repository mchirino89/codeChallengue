//
//  DetailsViewController.swift
//  Contacts
//
//  Created by Mauricio Chirino on 17/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import UIKit

protocol FavoriteActionable: class {
    func toggle(on userId: String)
}

class DetailsViewController: UIViewController {

    private var dataSource: DetailsDataSource!
    private weak var delegate: FavoriteActionable?

    private lazy var favoriteState: Bool = {
        return dataSource.isFavoriteUser
    }()

    private var currentFavoriteIcon: UIImage {
        return favoriteState ? #imageLiteral(resourceName: "true") : #imageLiteral(resourceName: "false")
    }

    @IBOutlet private weak var infoTableView: UITableView! {
        didSet {
            infoTableView.dataSource = dataSource
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setFavoriteButton()
        infoTableView.reloadData()
    }

    private func setFavoriteButton() {
        let favButton = UIBarButtonItem(image: currentFavoriteIcon, style: .plain, target: self, action: #selector(favoriteTapped))
        navigationItem.rightBarButtonItem = favButton
    }

    @objc
    private func favoriteTapped() {
        delegate?.toggle(on: dataSource.currentUser)
        // Find out why the data source state didn't reflect in here inmediately
        favoriteState.toggle()
        setFavoriteButton()
    }

    func setDataSource(with currentUser: User) {
        dataSource = DetailsDataSource(userData: currentUser)
    }

    func setFavoritable(delegate: FavoriteActionable) {
        self.delegate = delegate
    }

    deinit {
        delegate = nil
    }
}

