//
//  EpisodeDetailViewController.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 05/04/24.
//

import SwiftUI

final class EpisodeDetailViewController<ViewModel: IEpisodeDetailViewModel>: UIHostingController<EpisodeDetailView<ViewModel>> {
    
    // MARK: - Properties
    
    private let viewModel: ViewModel
    
    // MARK: - Life cycle
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(rootView: EpisodeDetailView(viewModel: viewModel))
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
