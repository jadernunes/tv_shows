//
//  ListShowsService.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import Foundation
import NetworkSession

protocol IListShowsService {
    func loadAll(page: Int) async throws -> [ShowDTO]
    func search(text: String) async throws -> [ShowDTO]
}

struct ListShowsService: IListShowsService {
    
    // MARK: - Properties
    
    private let network: INetwork
    
    // MARK: - Life cycle
    
    init(network: INetwork = NetworkInstance) {
        self.network = network
    }
    
    // MARK: - Methods
    
    func loadAll(page: Int) async throws -> [ShowDTO] {
        try await network
            .makeRequest(requester: ListShowsResources
                .loadAll(page: page))
    }
    
    func search(text: String) async throws -> [ShowDTO] {
        let result: [SearchResultDTO] = try await network
            .makeRequest(requester: ListShowsResources
                .search(text: text))
        
        return result.map { $0.show }
    }
}
