//
//  ShowDetailService.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 04/04/24.
//

import Foundation

protocol IShowDetailService {
    func loadEpisodes(showID: Int) async throws -> [EpisodeDTO]
}

struct ShowDetailService: IShowDetailService {
    
    // MARK: - Properties
    
    private let network: INetwork
    
    // MARK: - Life cycle
    
    init(network: INetwork = NetworkInstance) {
        self.network = network
    }
    
    // MARK: - Methods
    
    func loadEpisodes(showID: Int) async throws -> [EpisodeDTO] {
        try await network
            .makeRequest(requester: ShowDetailResources
                .loadEpisodes(showID: showID))
    }
}
