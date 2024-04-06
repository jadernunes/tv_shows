//
//  ShowDetailViewModel.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 04/04/24.
//

import SwiftUI

protocol IShowDetailViewModel: ObservableObject {
    var state: ShowDetailState { get }
    
    func loadData() async
}

final class ShowDetailViewModel: IShowDetailViewModel {
    
    @Published var state: ShowDetailState = .idle
    
    // MARK: - Properties
    
    private let coordinator: IShowDetailCoordinator?
    private let service: IShowDetailService
    private let show: Show
    
    // MARK: - Life cycle
    
    init(show: Show,
         coordinator: IShowDetailCoordinator? = nil,
         service: IShowDetailService = ShowDetailService()) {
        self.show = show
        self.coordinator = coordinator
        self.service = service
    }
    
    // MARK: - Methods
    
    @MainActor
    func loadData() async {
        state = .loading
        
        do {
            let episodesDTO = try await service.loadEpisodes(showID: show.id)
            setUpSeasons(episodes: episodesDTO.map { $0.asEpisode })
        } catch {
            state = .error
        }
    }
    
    private func setUpSeasons(episodes: [Episode]) {
        let seasons = episodes.reduce(into: [Int: [Episode]]()) { result, episode in
            let seasonID = episode.season
            
            if var episodesInSeason = result[seasonID] {
                episodesInSeason.append(episode)
                result[seasonID] = episodesInSeason
            } else {
                result[seasonID] = [episode]
            }
        }
        .map { Season(id: $0.key, episodes: $0.value) }
        .sorted(by: { $0.id < $1.id })
        
        state = .ready(show: show, seasons: seasons)
    }
}

struct Season: Equatable {
    let id: Int
    let episodes: [Episode]
}

enum ShowDetailState: Equatable {
    case idle, error, loading, empty, ready(show: Show, seasons: [Season])

    static func == (lhs: ShowDetailState, rhs: ShowDetailState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.error, .error), (.loading, .loading), (.empty, .empty):
            return true
        case let (.ready(show1, seasons1), .ready(show2, seasons2)):
            return seasons1 == seasons2 && show1 == show2
        default:
            return false
        }
    }
}
