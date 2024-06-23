//
//  NetworkMock.swift
//  tvshowsTests
//
//  Created by Jader Borba Nunes on 07/04/24.
//

import Foundation
import NetworkSession
@testable import tvshows

final class NetworkMock: INetwork {
    
    // MARK: - Properties

    private let data: Decodable?

    // MARK: - Life cycle

    init(data: Decodable) {
        self.data = data
    }

    // MARK: - Methods
    
    func makeRequest<T: Decodable>(requester: Requestable) async throws -> T {
        guard let data = data as? T else {
            throw NetworkErrorType.jsonEncodingFailed(error: NSError(domain: "Fail to decode", code: 0))
        }
        
        return data
    }
}
