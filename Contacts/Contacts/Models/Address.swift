//
//  Address.swift
//  Contacts
//
//  Created by Mauricio Chirino on 17/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

struct Address: Decodable {
    let street: String
    let city: String
    let state: String
    let country: String
    let zipCode: String

    var humanReadable: String {
        return street + "\n" + city + ", " + state + " " + zipCode + ", " + country
    }
}
