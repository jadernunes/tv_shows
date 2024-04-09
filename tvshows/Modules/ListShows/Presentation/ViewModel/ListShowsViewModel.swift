//
//  ListShowsViewModel.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import Combine
import Foundation
import SwiftUI

protocol IListShowsViewModel: ObservableObject {
    var state: ListShowsState { get }
    var search: String { get set }
    var selectedShow: Show? { get set }

    func shouldShowLoadMore(currentShow: Show) -> Bool
    func loadData(currentShow: Show?) async
    func openFavorites()
    func updateFavorites()
}

final class ListShowsViewModel: IListShowsViewModel {
    
    // MARK: - Properties
    
    @Published var state: ListShowsState = .idle
    @Published var search: String = ""
    @Published var selectedShow: Show?
    
    private let coordinator: IListShowsCoordinator?
    private let service: IListShowsService
    private let favoriteService: IFavoriteService
    private var shows = [Show]()
    private var searchedText: String = ""
    private var cancelables = Set<AnyCancellable>()
    
    //Pagination control
    private var page: Int = 0
    private var hasLoadedAll = false
    private var noShows: Bool {
        shows.isEmpty
    }
    private var shouldShowEmptyState: Bool {
        hasLoadedAll && noShows
    }
    
    // MARK: - Life cycle
    
    init(coordinator: IListShowsCoordinator? = nil,
         service: IListShowsService = ListShowsService(),
         favoriteService: IFavoriteService = FavoriteService()) {
        self.coordinator = coordinator
        self.service = service
        self.favoriteService = favoriteService
        
        bindSearchText()
        bindSelectedShow()
    }
    
    // MARK: - Methods
    
    @MainActor
    func loadData(currentShow: Show?) async {
        if currentShow == nil {
            await restartPagination()
        }
        
        let isCurrentShowEqualToLast = currentShow == shows.last
        
        guard isCurrentShowEqualToLast &&
                hasLoadedAll == false ||
                state == .error else {
            return
        }
        
        await requestData()
    }
    
    func shouldShowLoadMore(currentShow: Show) -> Bool {
        let isCurrentShowEqualToLast = currentShow == shows.last
        let isShowsNotEmpty = shows.isEmpty == false
        let isSearchNotEmpty = searchedText.isEmpty == false
        
        return (isCurrentShowEqualToLast && isShowsNotEmpty) ||
               (isCurrentShowEqualToLast && isSearchNotEmpty)
    }
    
    func presentDetail(show: Show) {
        coordinator?.presentDetails(show: show)
    }
    
    func openFavorites() {
        coordinator?.presentFavorites()
    }
    
    func updateFavorites() {
        let allFavorites = favoriteService.loadAll()
        shows = shows.map { show in
            var show = show
            show.isFavorite = allFavorites.contains(where: { $0.id == show.id })
            return show
        }
        state = .ready(shows: shows)
    }
    
    @MainActor
    private func restartPagination() async {
        page = 0
        hasLoadedAll = false
        shows = []
    }
    
    @MainActor
    private func requestData() async {
        if noShows {
            state = .loading
        }
        
        do {
            let allFavorites = favoriteService.loadAll()
            let data = try await service.loadAll(page: page)
            let isListEmpty = data.isEmpty
            hasLoadedAll = isListEmpty
            
            if canIncrementPage(isListEmpty) {
                page += 1
            }
            
            if shouldShowEmptyState {
                state = .empty
            }
            
            shows.append(contentsOf: data.map { showDTO in
                var asShow = showDTO.asShow
                asShow.isFavorite = allFavorites.contains(where: { $0.id == showDTO.id })
                return asShow
            })
            state = .ready(shows: shows)
        } catch {
            state = .error
        }
    }
    
    @MainActor
    private func requestSearch() async {
        if noShows {
            state = .loading
        }
        
        do {
            let allFavorites = favoriteService.loadAll()
            let data = try await service.search(text: searchedText)
            let isListEmpty = data.isEmpty
            hasLoadedAll = isListEmpty
            
            if canIncrementPage(isListEmpty) {
                page += 1
            }
            
            if shouldShowEmptyState {
                state = .empty
            }
            
            shows.append(contentsOf: data.map { showDTO in
                var asShow = showDTO.asShow
                asShow.isFavorite = allFavorites.contains(where: { $0.id == showDTO.id })
                return asShow
            })
            state = .ready(shows: shows)
        } catch {
            state = .error
        }
    }
    
    private func canIncrementPage(_ isListEmpty: Bool) -> Bool {
        isListEmpty == false
    }
    
    private func bindSearchText() {
        $search
            .debounce(for: 0.7, scheduler: RunLoop.main)
            .sink { [weak self] in
                guard let self else { return }
                
                guard ($0.isEmpty == false || self.searchedText.isEmpty == false),
                      $0 != self.searchedText
                else { return }
                
                self.searchedText = $0
                
                Task {
                    await self.restartPagination()
                    
                    if self.searchedText.isEmpty {
                        await self.requestData()
                    } else {
                        await self.requestSearch()
                    }
                }
            }
            .store(in: &cancelables)
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
