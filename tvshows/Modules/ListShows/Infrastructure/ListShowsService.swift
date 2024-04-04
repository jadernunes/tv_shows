//
//  ListShowsService.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import Foundation

protocol IListShowsService {
    func loadAll(page: Int) async throws -> [ShowDTO]
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
                .loadAll(page: page)
        )
    }
}
