//
//  Extensions.swift
//  Contacts
//
//  Created by Mauricio Chirino on 18/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueCell<T: UITableViewCell>(with id: String) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: id) as? T else {
            preconditionFailure("There's something wrong on table view cell settings")
        }
        return cell
    }
}

extension UIStoryboard {
    func instantiate<T: UIViewController>(from id: String) -> T {
        guard let newController = self.instantiateViewController(withIdentifier: id) as? T else {
            preconditionFailure("This id \(id) is not set in this storyboard")
        }
        return newController
    }
}
