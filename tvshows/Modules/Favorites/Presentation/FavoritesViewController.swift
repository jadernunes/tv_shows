//
//  FavoritesViewController.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 08/04/24.
//

import SwiftUI

final class FavoritesViewController<ViewModel: IFavoritesViewModel>: UIHostingController<FavoritesView<ViewModel>> {
    
    // MARK: - Properties
    
    private let viewModel: ViewModel
    
    // MARK: - Life cycle
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(rootView: FavoritesView(viewModel: viewModel))
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    // MARK: - Methods
    
    private func loadData() {
        Task {
            await viewModel.loadData()
        }
    }
}
