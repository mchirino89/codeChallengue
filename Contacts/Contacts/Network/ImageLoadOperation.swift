//
//  ImageDownloader.swift
//  Cocktailist
//
//  Created by Mauricio Chirino on 25/2/18.
//  Copyright © 2018 Mauricio Chirino. All rights reserved.
//

import UIKit

class ImageLoadOperation: Operation {
    typealias ImageLoadOperationCompletionHandlerType = ((UIImage) -> ())?
    var completionHandler: ImageLoadOperationCompletionHandlerType
    var image: UIImage?
    var url: URL
    
    init(_ url: URL) {
        self.url = url
    }
    
    override func main() {
        if isCancelled {
            return
        }
        queuePriority = .high
        UIImage.downloadImageFromUrl(url) { [weak self] (retrievedImage) in
            guard let strongSelf = self, !strongSelf.isCancelled, let image = retrievedImage else { return }
            
            strongSelf.image = image
            strongSelf.completionHandler?(image)
        }
    }
}

extension UIImage {
    static func downloadImageFromUrl(_ url: URL, completionHandler: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data) else {
                    print("error downloading image")
                    completionHandler(nil)
                    return
            }
            completionHandler(image)
        }).resume()
    }
}

extension UIImageView {
    func setImage(_ image: UIImage?) {
        guard let image = image else { return }
        DispatchQueue.main.async { [weak self]  in
            guard let strongSelf = self else { return }
            strongSelf.image = image
        }
    }
}

