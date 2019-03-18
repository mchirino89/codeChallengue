//
//  Phone.swift
//  Contacts
//
//  Created by Mauricio Chirino on 17/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

struct Phone {
    
    var directory: [String: String]

    init(work: String, home: String, mobile: String) {
        directory = [:]
        addTo(&directory, value: work, at: .work)
        addTo(&directory, value: home, at: .home)
        addTo(&directory, value: mobile, at: .mobile)
    }

    private func addTo(_ readable: inout [String: String], value: String, at key: PhoneKeys) {
        if !value.isEmpty {
            readable[key.rawValue.capitalizingFirstLetter()] = value
        }
    }

    func readablePhone(from key: String) -> (type: String, number: String) {
        guard let retrieved = directory[key] else { return ("", "") }
        return (key, retrieved)
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
