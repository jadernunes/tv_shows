//
//  ListShowsView.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import SwiftUI

struct ListShowsView<ViewModel: IListShowsViewModel>: View {
    
    // MARK: - Properties
    
    @ObservedObject private var viewModel: ViewModel

    // MARK: - Life cycle
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        switch viewModel.state {
        case .empty:
            EmptyView() // TODO: Handle it
        case .loading:
            loadingView
        case .error:
            EmptyView() // TODO: Handle it
        case let .ready(shows):
            loadContent(shows)
        default:
            EmptyView()
        }
    }
    
    private func loadContent(_ shows: [Show]) -> some View {
        NavigationStack {
            GeometryReader { geo in
                List {
                    ForEach(shows, id: \.id) { show in
                        ShowView(data: show,
                                  imageSize: geo.size.width * 0.25)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                        .task {
                            await viewModel.loadData(currentShow: show)
                        }
                        
                        if viewModel.shouldShowLoadMore(currentShow: show) {
                            loadingView
                        }
                    }
                }
                .navigationTitle(Localize.string(key: "listShows.title"))
                .navigationBarTitleDisplayMode(.inline)
                .listStyle(.plain)
                .frame(maxWidth: .infinity)
                .refreshable {
                    await viewModel.loadData(currentShow: nil)
                }
                .searchable(text: $viewModel.search)
            }
        }
    }
    
    private var loadingView: some View {
        VStack(alignment: .center) {
            LoaderView()
        }
        .frame(maxWidth: .infinity)
    }
}
