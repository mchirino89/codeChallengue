//
//  Phone.swift
//  Contacts
//
//  Created by Mauricio Chirino on 17/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

struct Phone {
    let work: String
    let home: String
    let mobile: String

    init(work: String, home: String, mobile: String) {
        self.work = work
        self.home = home
        self.mobile = mobile
    }
}

extension Phone: Decodable {
    enum PhoneKeys: String, CodingKey {
        case work
        case home
        case mobile
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PhoneKeys.self)
        let decodedWork = try container.decodeIfPresent(String.self, forKey: .work) ?? ""
        let decodedHome = try container.decodeIfPresent(String.self, forKey: .home) ?? ""
        let decodedMobile = try container.decodeIfPresent(String.self, forKey: .mobile) ?? ""
        self.init(work: decodedWork, home: decodedHome, mobile: decodedMobile)
    }
}
