//
//  ListViewController.swift
//  Contacts
//
//  Created by Mauricio Chirino on 17/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import Alamofire

enum UIState {
    case dataLoading
    case dataLoaded
    case dataFailure
}

class ListViewController: UIViewController {

    private lazy var dataSource: ContactsDataSource = {
        return ContactsDataSource(delegate: self)
    }()

    private var currentState: UIState = .dataLoading

    @IBOutlet private weak var contactsTableView: UITableView! {
        didSet {
            contactsTableView.delegate = self
            contactsTableView.dataSource = dataSource
        }
    }

}

extension ListViewController: ContactsDataSourcable {
    /// Gets notify when the data source is updated
    func updateUI(currentState: UIState) {
        self.currentState = currentState
        switch currentState {
        case .dataLoaded:
            contactsTableView.reloadData()
        default:
            NSLog("Something went wrong along the way")
        }
    }
}

extension ListViewController: UITableViewDelegate {
    /// Notifies which cell was selected to coordinate transition
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
