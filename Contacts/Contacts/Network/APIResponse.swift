//
//  APIResponse.swift
//  Contacts
//
//  Created by Mauricio Chirino on 17/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import Alamofire

enum DataState {
    case loaded([User])
    case failure(Error)
}

protocol ResponseHandable: class {
    func responseOutput(result: DataState)
}

class APIResponse {

    private weak var delegate: ResponseHandable?

    init(delegate: ResponseHandable) {
        self.delegate = delegate
    }

    func fetchUsers() {
        NetworkLayer.shared.getData(from: Constants.rootURL) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let value):
                self.handleSuccessResponse(for: value, and: self.delegate)
            case .failure(let errorInfo):
                self.handleFailure(for: errorInfo, and: self.delegate)
            }
        }
    }

    private func handleSuccessResponse(for data: Data, and delegate: ResponseHandable?) {
        let decode = JSONDecoder()
        do {
            let users: [User] = try decode.decode([User].self, from: data)
            let success: DataState = .loaded(users)
            delegate?.responseOutput(result: success)
        } catch let error {
            handleFailure(for: error, and: delegate)
        }
    }

    private func handleFailure(for error: Error, and delegate: ResponseHandable?) {
        print("Something went wrong during JSON decoding \(error.localizedDescription)")
        let failure: DataState = .failure(error)
        delegate?.responseOutput(result: failure)
    }
}
