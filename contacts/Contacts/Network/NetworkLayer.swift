//
//  NetworkLayer.swift
//  Contacts
//
//  Created by Mauricio Chirino on 17/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import Alamofire

enum ResourceType: String {
    case json
    case txt
}

class NetworkLayer {

    static let shared = NetworkLayer()
    private init() { }

    func getData(from originURL: String, using completion: @escaping (Result<Data>) -> ()) {
        Alamofire.request(originURL).validate().responseData { response in
            print(response.result.description)
            completion(response.result)
        }
    }

    func getStub<T: Decodable>(from resource: String, with type: ResourceType) -> [T] {
        let decoder = JSONDecoder()
        do {
            guard let file = Bundle.main.url(forResource: resource, withExtension: type.rawValue) else {
                print("File \(resource).\(type.rawValue) not found")
                return []
            }
            let data = try Data(contentsOf: file)
            return try decoder.decode([T].self, from: data)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
