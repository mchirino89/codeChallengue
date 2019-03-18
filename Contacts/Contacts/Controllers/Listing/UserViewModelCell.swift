//
//  UserViewModel.swift
//  Contacts
//
//  Created by Mauricio Chirino on 17/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import UIKit

class UserViewModel: UITableViewCell {

    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var favoriteWidth: NSLayoutConstraint!
    @IBOutlet weak var thumbnailActivityIndicator: UIActivityIndicatorView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainStackView.spacing = bounds.width * 0.05
        favoriteWidth.constant = bounds.width * 0.05
    }

    func configureCell(with userData: User) {
        favoriteImageView.isHidden = !userData.isFavorite
        nameLabel.text = userData.name
        companyLabel.text = userData.companyName
        NetworkLayer.shared.getImage(from: userData.smallImageURL) { response in
            DispatchQueue.main.async { [weak self] in
                switch response {
                case .success(let image):
                    self?.thumbnailImageView.image = image
                case .failure(_):
                    self?.thumbnailImageView.image = #imageLiteral(resourceName: "UserSmall")
                }
                self?.thumbnailActivityIndicator.stopAnimating()
            }
        }
    }

}
