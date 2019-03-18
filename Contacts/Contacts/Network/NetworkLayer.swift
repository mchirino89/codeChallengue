//
//  NetworkLayer.swift
//  Contacts
//
//  Created by Mauricio Chirino on 17/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import Alamofire
import AlamofireImage

enum ResourceType: String {
    case json
    case txt
}

class NetworkLayer {

    static let shared = NetworkLayer()
    private let imageCache: AutoPurgingImageCache

    private init() {
        imageCache = AutoPurgingImageCache()
    }

    func getData(from originURL: String, using completion: @escaping (Result<Data>) -> ()) {
        Alamofire.request(originURL).validate().responseData { response in
            print(response.result.description)
            completion(response.result)
        }
    }

    func getImage(from originURL: String, using completion: @escaping (Result<Image>) -> ()) {
        guard let savedImage = imageCache.image(withIdentifier: originURL) else {
            Alamofire.request(originURL).responseImage { retrievedImage in
                print(retrievedImage.description)
                completion(retrievedImage.result)
            }
            return
        }
        let success: Result<Image> = .success(savedImage)
        completion(success)
    }

    func updateCache(with image: UIImage, at key: String) {
        imageCache.add(image, withIdentifier: key)
    }

    /// In case of any local testing, use this method to load a local valid JSON file
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

