//
//  InfoViewModelCell.swift
//  Contacts
//
//  Created by Mauricio Chirino on 18/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import UIKit

protocol DetailsSetable {
    func setInfo(content: String, title: String)
}

class InfoViewModelCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    func configureCell(basedOn dictionary: [String: String]) {
        
    }

}

extension InfoViewModelCell: DetailsSetable {
    func setInfo(content: String, title: String) {
        contentLabel.text = content
        titleLabel.text = title
    }
}
