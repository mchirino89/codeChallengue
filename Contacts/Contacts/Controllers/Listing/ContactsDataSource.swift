//
//  ContactsDataSource.swift
//  Contacts
//
//  Created by Mauricio Chirino on 17/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import UIKit

class ContactsDataSource: NSObject {

    private var users: [User]
    private let cellId: String

    init(cellId: String) {
        self.cellId = cellId
        self.users = []
    }

    func update(users: [User] = []) {
        self.users = users
    }

}

extension ContactsDataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? UserViewModel else {
            return UITableViewCell()
        }
        cell.configureCell(with: users[indexPath.row])
        return cell
    }

    
}
