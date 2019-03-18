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
            contactsTableView.rowHeight = 120
        }
    }

    @IBOutlet weak var loadingActivitiyIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        apiCall.fetchUsers()
    }

}

extension ListViewController: ResponseHandable {
    func responseOutput(result: DataState) {
        switch result {
        case .loaded(let received):
            dataSource.update(with: received)
        case .failure(_):
            contactsTableView.isHidden = true
            dataSource.update()
        }
        loadingActivitiyIndicator.stopAnimating()
        contactsTableView.reloadData()
    }
}

extension ListViewController: UITableViewDelegate {
    /// Notifies which cell was selected to coordinate transition
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
