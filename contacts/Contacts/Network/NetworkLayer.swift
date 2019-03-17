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

    func getStub<T: Decodable>(from resource: String) -> [T] {
        let decoder = JSONDecoder()
        do {
            guard let file = Bundle.main.url(forResource: resource, withExtension: "json") else {
                print("File \(resource).json not found")
                return []
            }
            let data    = try Data(contentsOf: file)
            return try decoder.decode([T].self, from: data)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
