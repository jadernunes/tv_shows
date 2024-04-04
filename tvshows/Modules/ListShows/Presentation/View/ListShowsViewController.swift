//
//  ListShowsViewController.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import SwiftUI

final class ListShowsViewController<ViewModel: IListShowsViewModel>: UIHostingController<ListShowsView<ViewModel>> {
    
    // MARK: - Properties
    
    private let viewModel: ViewModel
    
    // MARK: - Life cycle
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(rootView: ListShowsView(viewModel: viewModel))
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
            await viewModel.loadData(currentShow: nil)
        }
    }
}
