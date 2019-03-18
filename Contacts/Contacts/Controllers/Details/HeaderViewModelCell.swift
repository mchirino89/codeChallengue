//
//  HeaderViewModelCell.swift
//  Contacts
//
//  Created by Mauricio Chirino on 18/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import UIKit

class HeaderViewModelCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!

    func configureCell(with info: User) {
        setInfo(content: info.name, title: info.companyName)
        // Set image placeholder
    }
}

extension HeaderViewModelCell: DetailsSetable {
    func setInfo(content: String, title: String) {
        nameLabel.text = content
        companyLabel.text = title
    }
}
