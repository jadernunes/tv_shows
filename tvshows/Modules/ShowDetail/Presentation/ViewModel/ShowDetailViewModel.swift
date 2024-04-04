//
//  ShowDetailViewModel.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 04/04/24.
//

import SwiftUI

protocol IShowDetailViewModel: ObservableObject {
    var show: Show { get }
    
    func loadData() async
}

final class ShowDetailViewModel: IShowDetailViewModel {
    
    @Published var show: Show
    
    // MARK: - Properties
    
    private let coordinator: IShowDetailCoordinator?
    private let service: IShowDetailService
    
    // MARK: - Life cycle
    
    init(show: Show,
         coordinator: IShowDetailCoordinator? = nil,
         service: IShowDetailService = ShowDetailService()) {
        self.show = show
        self.coordinator = coordinator
        self.service = service
    }
    
    // MARK: - Methods
    
    func loadData() async {
        // TODO: Handle it
    }
}
