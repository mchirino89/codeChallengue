//
//  ContactsDataSource.swift
//  Contacts
//
//  Created by Mauricio Chirino on 17/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import UIKit

enum Headers: String, CaseIterable {
    case favorite = "FAVORITE CONTACTS"
    case others = "OTHER CONTACTS"
}

class ContactsDataSource: NSObject {

    private var users: [User]
    private var groupedUsers: [[User]]
    private let cellId: String

    init(cellId: String) {
        self.cellId = cellId
        users = []
        groupedUsers = [[], []]
    }

    func update(with users: [User] = []) {
        self.users = users
        sortGrouped()
    }

    func getUser(at index: IndexPath) -> User {
        return groupedUsers[index.section][index.row]
    }

    func toggleFavorite(for userId: String) {
        guard var newValue = users.first(where: { $0.id == userId }) else { return }
        guard let foundIndex = users.firstIndex(where: { $0.id == userId }) else { return }
        newValue.isFavorite.toggle()
        users[foundIndex] = newValue
        sortGrouped()
    }

    private func sortGrouped() {
        groupedUsers.removeAll()
        groupedUsers.append(sortedFractionOf(favorite: true))
        groupedUsers.append(sortedFractionOf(favorite: false))
    }

    private func sortedFractionOf(favorite: Bool) -> [User] {
        return users.filter( { $0.isFavorite == favorite } ).sorted(by: { $0.name < $1.name })
    }
}

extension ContactsDataSource: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedUsers.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedUsers[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserViewModel = tableView.dequeueCell(with: cellId)
        cell.configureCell(with: groupedUsers[indexPath.section][indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Headers.allCases[section].rawValue
    }

}
