//
//  ShowDetailViewModel.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 04/04/24.
//

import SwiftUI

protocol IShowDetailViewModel: ObservableObject {
    func loadData() async
}

final class ShowDetailViewModel: IShowDetailViewModel {
    
    // MARK: - Properties
    
    private let coordinator: IShowDetailCoordinator?
    private let service: IShowDetailService
    
    // MARK: - Life cycle
    
    init(coordinator: IShowDetailCoordinator? = nil,
         service: IShowDetailService = ShowDetailService()) {
        self.coordinator = coordinator
        self.service = service
    }
    
    // MARK: - Methods
    
    func loadData() async {
        // TODO: Handle it
    }
}
