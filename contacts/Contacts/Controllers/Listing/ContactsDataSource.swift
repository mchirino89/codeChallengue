//
//  ContactsDataSource.swift
//  Contacts
//
//  Created by Mauricio Chirino on 17/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import Alamofire

protocol ContactsDataSourcable: class {
    func updateUI(currentState: UIState)
}

class ContactsDataSource: NSObject {

    private var users: [User] = []

    init(delegate: ContactsDataSourcable) {
        super.init()
        NetworkLayer.shared.getData(from: Constants.rootURL) { [weak self] response in
            switch response {
            case .success(let value):
                self?.handleSuccessResponse(for: value, and: delegate)
            case .failure(let errorInfo):
                self?.handleFailure(for: errorInfo, and: delegate)
            }
        }
    }

    private func handleSuccessResponse(for data: Data, and delegate: ContactsDataSourcable) {
        let decode = JSONDecoder()
        do {
            users = try decode.decode([User].self, from: data)
            delegate.updateUI(currentState: .dataLoaded)
        } catch let error {
            handleFailure(for: error, and: delegate)
        }
    }

    private func handleFailure(for error: Error, and delegate: ContactsDataSourcable) {
        print("Something went wrong during JSON decoding \(error.localizedDescription)")
        delegate.updateUI(currentState: .dataFailure)
    }
}

extension ContactsDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
