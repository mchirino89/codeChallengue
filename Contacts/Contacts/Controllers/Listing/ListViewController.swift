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
        let cellId = "userCell"
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

    override func viewDidLoad() {
        super.viewDidLoad()
        apiCall.fetchUsers()
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
