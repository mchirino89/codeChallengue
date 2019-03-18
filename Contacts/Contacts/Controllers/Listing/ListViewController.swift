//
//  ListViewController.swift
//  Contacts
//
//  Created by Mauricio Chirino on 17/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import Alamofire

enum DataState {
    case loaded([User])
    case failure(Error)
}

class ListViewController: UIViewController {

    private let cellId = "userCell"

    private lazy var dataSource: ContactsDataSource = {
        return ContactsDataSource(cellId: cellId)
    }()

    private lazy var apiCall: APIResponse = {
        return APIResponse(delegate: self)
    }()

    @IBOutlet private weak var contactsTableView: UITableView! {
        didSet {
            contactsTableView.delegate = self
            contactsTableView.dataSource = dataSource
        }
    }

}

extension ListViewController: ResponseHandable {
    func responseOutput(result: DataState) {
        switch result {
        case .loaded(let received):
            dataSource.update(users: received)
        case .failure(_):
            dataSource.update()
        }
        contactsTableView.reloadData()
    }
}

extension ListViewController: UITableViewDelegate {
    /// Notifies which cell was selected to coordinate transition
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
