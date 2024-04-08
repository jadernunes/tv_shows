//
//  EpisodeDetailViewModel.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 05/04/24.
//

import SwiftUI

protocol IEpisodeDetailViewModel: ObservableObject {
    var episode: Episode { get }
    
    func close()
}

final class EpisodeDetailViewModel: IEpisodeDetailViewModel {
    
    // MARK: - Properties
    
    @Published var episode: Episode
    private let coordinator: IEpisodeDetailCoordinator?
    
    // MARK: - Life cycle
    
    init(episode: Episode,
         coordinator: IEpisodeDetailCoordinator? = nil) {
        self.episode = episode
        self.coordinator = coordinator
    }
    
    func close() {
        coordinator?.close()
    }
}
