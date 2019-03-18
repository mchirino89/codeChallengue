//
//  User.swift
//  Contacts
//
//  Created by Mauricio Chirino on 17/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import Foundation

struct User {
    let name: String
    let id: String
    let companyName: String
    let isFavorite: Bool
    let smallImageURL: URL?
    let largeImageURL: URL?
    let emailAddress: String
    let birthdate: String
    let phone: Phone
    let address: Address

    init(name: String,
         id: String,
         companyName: String,
         isFavorite: Bool,
         smallImageURL: URL?,
         largeImageURL: URL?,
         emailAddress: String,
         birthdate: String,
         phone: Phone,
         address: Address) {
        self.name = name
        self.id = id
        self.companyName = companyName
        self.isFavorite = isFavorite
        self.smallImageURL = smallImageURL
        self.largeImageURL = largeImageURL
        self.emailAddress = emailAddress
        self.birthdate = birthdate
        self.phone = phone
        self.address = address
    }
}

extension User: Decodable {
    enum UserCodingKey: String, CodingKey {
        case name
        case id
        case companyName
        case isFavorite
        case smallImageURL
        case largeImageURL
        case emailAddress
        case birthdate
        case phone
        case address
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKey.self)
        let decodedName = try container.decode(String.self, forKey: .name)
        let decodedId = try container.decode(String.self, forKey: .id)
        let decodedCompanyName = try container.decodeIfPresent(String.self, forKey: .companyName) ?? ""
        let decodedFavorite = try container.decode(Bool.self, forKey: .isFavorite)
        let decodedSmallImage = try container.decode(String.self, forKey: .smallImageURL)
        let parseSmallImageURL = URL(string: decodedSmallImage)
        let decodedLargeImage = try container.decode(String.self, forKey: .largeImageURL)
        let parseLargeImageURL = URL(string: decodedLargeImage)
        let decodedEmail = try container.decode(String.self, forKey: .emailAddress)
        let decodedBirthday = try container.decode(String.self, forKey: .birthdate)
        let decodedPhone = try container.decode(Phone.self, forKey: .phone)
        let decodedAddress = try container.decode(Address.self, forKey: .address)

        self.init(name: decodedName,
                  id: decodedId,
                  companyName: decodedCompanyName,
                  isFavorite: decodedFavorite,
                  smallImageURL: parseSmallImageURL,
                  largeImageURL: parseLargeImageURL,
                  emailAddress: decodedEmail,
                  birthdate: decodedBirthday,
                  phone: decodedPhone,
                  address: decodedAddress)
    }
}
