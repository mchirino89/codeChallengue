//
//  DetailsViewController.swift
//  Contacts
//
//  Created by Mauricio Chirino on 17/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import UIKit

protocol FavoriteActionable: class {
    func toggle()
}

class DetailsViewController: UIViewController {

    private var dataSource: DetailsDataSource!
    private weak var delegate: FavoriteActionable?

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
        let buttonImage = dataSource.isFavoriteUser ? #imageLiteral(resourceName: "true") : #imageLiteral(resourceName: "false")
        let favButton = UIBarButtonItem(image: buttonImage, style: .plain, target: self, action: #selector(favoriteTapped))
        navigationItem.rightBarButtonItem = favButton
    }

    @objc
    private func favoriteTapped() {
        print("Tapped on favorite")
        delegate?.toggle()
    }

    func setDataSource(with currentUser: User) {
        dataSource = DetailsDataSource(userData: currentUser)
    }

    func setFavorite(delegate: FavoriteActionable) {
        self.delegate = delegate
    }
}

