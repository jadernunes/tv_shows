//
//  FavoritesViewModel.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 08/04/24.
//

import Combine
import SwiftUI

protocol IFavoritesViewModel: ObservableObject {
    var state: ListShowsState { get }
    var selectedShow: Show? { get set }
    
    func loadData() async
    func delete(index: Int) async
}

final class FavoritesViewModel: IFavoritesViewModel {
    
    // MARK: - Properties
    
    @Published var state: ListShowsState = .idle
    @Published var selectedShow: Show?
    
    private let coordinator: IFavoritesCoordinator?
    private let favoriteService: IFavoriteService
    private var cancelables = Set<AnyCancellable>()
    private var shows = [Show]()
    
    // MARK: - Life cycle
    
    init(coordinator: IFavoritesCoordinator? = nil,
         service: IListShowsService = ListShowsService(),
         favoriteService: IFavoriteService = FavoriteService()) {
        self.coordinator = coordinator
        self.favoriteService = favoriteService
        
        bindSelectedShow()
    }
    
    @MainActor
    func loadData() async {
        let allFavorites = favoriteService.loadAll()
        shows = allFavorites
            .map { $0.asShow }
            .sorted(by: { $0.name.lowercased() < $1.name.lowercased() })
        
        state = shows.isEmpty ? .empty : .ready(shows: shows)
    }
    
    @MainActor
    func delete(index: Int) async {
        guard let show = shows[safe: index] else { return }
        favoriteService.remove(id: show.id)
        await loadData()
    }
    
    private func bindSelectedShow() {
        $selectedShow
            .sink { [weak self] show in
                guard let show else { return }
                self?.coordinator?.presentDetails(show: show)
            }
            .store(in: &cancelables)
    }
}
