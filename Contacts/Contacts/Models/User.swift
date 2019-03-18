//
//  User.swift
//  Contacts
//
//  Created by Mauricio Chirino on 17/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import Foundation

private enum GeneralInfoKey: String, CaseIterable {
    case address
    case birthdate
    case email

    var titleTag: String {
        return self.rawValue.capitalized
    }
}

struct User {
    let name: String
    let id: String
    let companyName: String
    var isFavorite: Bool
    let smallImageURL: String
    let largeImageURL: String
    let emailAddress: String
    let birthdate: String
    let phone: Phone
    let address: Address
    var generalInfo: [String: String]

    init(name: String,
         id: String,
         companyName: String,
         isFavorite: Bool,
         smallImageURL: String,
         largeImageURL: String,
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
        generalInfo = [:]
        setGeneralInfo()
    }

    private mutating func setGeneralInfo() {
        generalInfo[GeneralInfoKey.address.titleTag] = address.humanReadable
        generalInfo[GeneralInfoKey.birthdate.titleTag] = birthdate.readableDate
        generalInfo[GeneralInfoKey.email.titleTag] = emailAddress
    }

    func getDetails(at key: String) -> (type: String, content: String) {
        guard let retrieved = generalInfo[key] else { return ("", "") }
        return (key, retrieved)
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
        let decodedCompanyName = try container.decodeIfPresent(String.self, forKey: .companyName) ?? " "
        let decodedFavorite = try container.decode(Bool.self, forKey: .isFavorite)
        let decodedSmallImage = try container.decode(String.self, forKey: .smallImageURL)
        let decodedLargeImage = try container.decode(String.self, forKey: .largeImageURL)
        let decodedEmail = try container.decode(String.self, forKey: .emailAddress)
        let decodedBirthday = try container.decode(String.self, forKey: .birthdate)
        let decodedPhone = try container.decode(Phone.self, forKey: .phone)
        let decodedAddress = try container.decode(Address.self, forKey: .address)

        self.init(name: decodedName,
                  id: decodedId,
                  companyName: decodedCompanyName,
                  isFavorite: decodedFavorite,
                  smallImageURL: decodedSmallImage,
                  largeImageURL: decodedLargeImage,
                  emailAddress: decodedEmail,
                  birthdate: decodedBirthday,
                  phone: decodedPhone,
                  address: decodedAddress)
    }
}
