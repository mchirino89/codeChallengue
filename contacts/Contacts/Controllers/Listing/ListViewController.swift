//
//  ListViewController.swift
//  Contacts
//
//  Created by Mauricio Chirino on 17/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import Alamofire

class ListViewController: UIViewController {

    private lazy var dataSource: ContactsDataSource = {
        return ContactsDataSource(delegate: self)
    }()

    @IBOutlet private weak var contactsTableView: UITableView! {
        didSet {
            contactsTableView.delegate = self
            contactsTableView.dataSource = dataSource
        }
    }

}

extension ListViewController: ContactsDataSourcable {
    /// Gets notify when the data source is updated
    func updateUI() {
        contactsTableView.reloadData()
    }
}

extension ListViewController: UITableViewDelegate {
    /// Notifies which cell was selected to coordinate transition
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
