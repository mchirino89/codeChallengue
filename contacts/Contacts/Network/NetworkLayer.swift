//
//  NetworkLayer.swift
//  Contacts
//
//  Created by Mauricio Chirino on 17/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import Alamofire

class NetworkLayer {

    static let shared = NetworkLayer()
    private init() { }

    func getJSON(from originURL: String, using completion: @escaping (Result<Any>) -> ()) {
        Alamofire.request(originURL).validate().responseJSON { response in
            completion(response.result)
        }
    }
}
