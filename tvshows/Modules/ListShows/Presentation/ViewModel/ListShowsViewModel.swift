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

    func shouldShowLoadMore(currentShow: Show) -> Bool
    func loadData(currentShow: Show?) async
}

final class ListShowsViewModel: IListShowsViewModel {
    
    // MARK: - Properties
    
    @Published var state: ListShowsState = .idle
    
    private let coordinator: IListShowsCoordinator?
    private let service: IListShowsService
    private var shows = [Show]()
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
         service: IListShowsService = ListShowsService()) {
        self.coordinator = coordinator
        self.service = service
    }
    
    // MARK: - Methods
    
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
        
        return (isCurrentShowEqualToLast && isShowsNotEmpty)
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
            let data = try await service.loadAll(page: page)
            let isListEmpty = data.isEmpty
            hasLoadedAll = isListEmpty
            
            if canIncrementPage(isListEmpty) {
                page += 1
            }
            
            if shouldShowEmptyState {
                state = .empty
            }
            
            shows.append(contentsOf: data.map { $0.asShow })
            state = .ready(shows: shows)
        } catch {
            state = .error
        }
    }
    
    private func canIncrementPage(_ isListEmpty: Bool) -> Bool {
        isListEmpty == false
    }
}
