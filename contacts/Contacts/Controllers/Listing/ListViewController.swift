//
//  ListViewController.swift
//  Contacts
//
//  Created by Mauricio Chirino on 17/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    private let dataSource = ContactsDataSource()

    @IBOutlet private weak var contactsTableView: UITableView! {
        didSet {
            contactsTableView.delegate = self
            contactsTableView.dataSource = dataSource
        }
    }

}

extension ListViewController: UITableViewDelegate {
    /// Notifies which cell was selected to coordinate transition
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
