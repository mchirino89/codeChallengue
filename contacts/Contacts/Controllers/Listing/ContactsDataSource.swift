//
//  ContactsDataSource.swift
//  Contacts
//
//  Created by Mauricio Chirino on 17/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import Alamofire

protocol ContactsDataSourcable: class {
    func updateUI()
}

class ContactsDataSource: NSObject {

    private weak var delegate: ContactsDataSourcable?

    init(delegate: ContactsDataSourcable) {
        self.delegate = delegate
        NetworkLayer.shared.getJSON(from: Constants.rootURL) { response in
            switch response {
            case .success(let value):
                print("Success! \(value)")
            case .failure(let errorInfo):
                print("Something went wrong: \(errorInfo.localizedDescription)")
            }
        }
    }

}

extension ContactsDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
