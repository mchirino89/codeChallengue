//
//  APIResponse.swift
//  Contacts
//
//  Created by Mauricio Chirino on 17/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import Alamofire

protocol ResponseHandable: class {
    func responseOutput(result: DataState)
}

class APIResponse {

    init(delegate: ResponseHandable) {
        NetworkLayer.shared.getData(from: Constants.rootURL) { [weak self] response in
            switch response {
            case .success(let value):
                self?.handleSuccessResponse(for: value, and: delegate)
            case .failure(let errorInfo):
                self?.handleFailure(for: errorInfo, and: delegate)
            }
        }
    }

    private func handleSuccessResponse(for data: Data, and delegate: ResponseHandable) {
        let decode = JSONDecoder()
        do {
            let users: [User] = try decode.decode([User].self, from: data)
            let success: DataState = .loaded(users)
            delegate.responseOutput(result: success)
        } catch let error {
            handleFailure(for: error, and: delegate)
        }
    }

    private func handleFailure(for error: Error, and delegate: ResponseHandable) {
        print("Something went wrong during JSON decoding \(error.localizedDescription)")
        let failure: DataState = .failure(error)
        delegate.responseOutput(result: failure)
    }
}
