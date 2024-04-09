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
    func updateFavorite()
}

final class ShowDetailViewModel: IShowDetailViewModel {
    
    // MARK: - Properties
    
    @Published var state: ShowDetailState = .idle
    @Published var selectedEpisode: Episode?
    
    private let coordinator: IShowDetailCoordinator?
    private let service: IShowDetailService
    private let favoriteService: IFavoriteService
    private var show: Show
    private var episodesDTO: [EpisodeDTO] = []
    private var cancelables = Set<AnyCancellable>()
    
    // MARK: - Life cycle
    
    init(show: Show,
         coordinator: IShowDetailCoordinator? = nil,
         service: IShowDetailService = ShowDetailService(),
         favoriteService: IFavoriteService = FavoriteService()) {
        self.show = show
        self.coordinator = coordinator
        self.service = service
        self.favoriteService = favoriteService
        
        bindSelectedEpisode()
    }
    
    // MARK: - Methods
    
    @MainActor
    func loadData() async {
        state = .loading
        
        do {
            episodesDTO = try await service.loadEpisodes(showID: show.id)
            setUpSeasons()
        } catch {
            state = .error
        }
    }
    
    func updateFavorite() {
        if show.isFavorite {
            favoriteService.remove(id: show.id)
            show.isFavorite = false
        } else {
            favoriteService.add(model: ShowDTO(show: show))
            show.isFavorite = true
        }
        
        setUpSeasons()
    }
    
    private func setUpSeasons() {
        let episodes = episodesDTO.map { $0.asEpisode }
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
