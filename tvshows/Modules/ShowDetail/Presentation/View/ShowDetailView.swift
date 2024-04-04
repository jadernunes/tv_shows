//
//  ShowDetailView.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 04/04/24.
//

import SwiftUI

struct ShowDetailView<ViewModel: IShowDetailViewModel>: View {
    
    // MARK: - Properties
    
    @ObservedObject private var viewModel: ViewModel

    // MARK: - Life cycle
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            EmptyView()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
