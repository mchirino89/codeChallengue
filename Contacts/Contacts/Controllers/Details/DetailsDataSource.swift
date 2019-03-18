//
//  DetailsDataSource.swift
//  Contacts
//
//  Created by Mauricio Chirino on 18/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import UIKit

private enum InfoSections: Int, CaseIterable {
    case header
    case phone
    case general
}

private enum cellId: String, CaseIterable {
    case headerCell
    case phoneCell
    case infoCell
}

class DetailsDataSource: NSObject {

    private let userData: User

    init(userData: User) {
        self.userData = userData
    }

    var isFavoriteUser: Bool {
        return userData.isFavorite
    }

    private func getCurrent(_ section: Int) -> InfoSections {
        guard let currentSection = InfoSections.init(rawValue: section) else {
            preconditionFailure("Something went wrong during section layout handling")
        }
        return currentSection
    }
}

extension DetailsDataSource: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return InfoSections.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch getCurrent(section) {
        case .header:
            return 1
        case .phone:
            return userData.phone.directory.count
        case .general:
            return 3
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentId = cellId.allCases[indexPath.section].rawValue
        switch getCurrent(indexPath.section) {
        case .header:
            let cell: HeaderViewModelCell = tableView.dequeueCell(with: currentId)
            cell.configureCell(with: userData)
            return cell
        case .phone:
            let cell: InfoViewModelCell = tableView.dequeueCell(with: currentId)
//            cell.setInfo(content: userData.phone.readableDirectory.values[indexPath.row], title: userData.phone.readableDirectory.keys[indexPath.row])
            return cell
        default:
            let cell: InfoViewModelCell = tableView.dequeueCell(with: currentId)
//            cell.setInfo(content: <#T##String#>, title: <#T##String#>)
            return cell
        }
    }
}
