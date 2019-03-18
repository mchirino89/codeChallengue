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
    @IBOutlet weak var loadActivityIndicator: UIActivityIndicatorView!
    
    func configureCell(with info: User) {
        setInfo(content: info.name, title: info.companyName)
        NetworkLayer.shared.getImage(from: info.largeImageURL) { response in
            DispatchQueue.main.async { [weak self] in
                switch response {
                case .success(let image):
                    self?.userImageView.image = image
                case .failure(_):
                    self?.userImageView.image = #imageLiteral(resourceName: "UserSmall")
                }
                self?.loadActivityIndicator.stopAnimating()
            }
        }
    }
}

extension HeaderViewModelCell: DetailsSetable {
    func setInfo(content: String, title: String) {
        nameLabel.text = content
        companyLabel.text = title
    }
}
