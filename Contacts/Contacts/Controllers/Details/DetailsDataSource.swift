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

    private var userData: User
    private let sectionsCount: [Int]
    private let availablePhones: [String]
    private let generalInfo: [String]

    init(userData: User) {
        self.userData = userData
        // Not sure if handling sections is safer this way than the switch alternative inside the delegate's method
        sectionsCount = [1, userData.phone.directory.count, userData.generalInfo.count]
        availablePhones = Array(userData.phone.directory.keys)
        generalInfo = Array(userData.generalInfo.keys)
    }

    var isFavoriteUser: Bool {
        return userData.isFavorite
    }

    var currentUser: String {
        return userData.id
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
        return sectionsCount[section]
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
            let currentPhone = userData.phone.readablePhone(from: availablePhones[indexPath.row])
            cell.setInfo(content: currentPhone.number, title: currentPhone.type)
            return cell
        default:
            let cell: InfoViewModelCell = tableView.dequeueCell(with: currentId)
            let currentInfo = userData.getDetails(at: generalInfo[indexPath.row])
            cell.setInfo(content: currentInfo.content, title: currentInfo.type)
            return cell
        }
    }
}
