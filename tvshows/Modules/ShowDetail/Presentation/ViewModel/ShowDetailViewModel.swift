//
//  ShowDetailViewModel.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 04/04/24.
//

import Combine
import SwiftUI

protocol IShowDetailViewModel: ObservableObject {
    var state: ShowDetailState { get }
    var selectedEpisode: Episode? { get set }
    
    func loadData() async
}

final class ShowDetailViewModel: IShowDetailViewModel {
    
    // MARK: - Properties
    
    @Published var state: ShowDetailState = .idle
    @Published var selectedEpisode: Episode?
    
    private let coordinator: IShowDetailCoordinator?
    private let service: IShowDetailService
    private let show: Show
    private var cancelables = Set<AnyCancellable>()
    
    // MARK: - Life cycle
    
    init(show: Show,
         coordinator: IShowDetailCoordinator? = nil,
         service: IShowDetailService = ShowDetailService()) {
        self.show = show
        self.coordinator = coordinator
        self.service = service
        
        bindSelectedEpisode()
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
    
    private func bindSelectedEpisode() {
        $selectedEpisode
            .sink { [weak self] episode in
                guard let episode else { return }
                self?.coordinator?.showEpisodeDetail(episode: episode)
            }
            .store(in: &cancelables)
    }
}
