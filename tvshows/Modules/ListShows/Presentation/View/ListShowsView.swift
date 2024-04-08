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
            MessageRetryView(imageName: "noData", message: Localize.string(key: "noData"))
                .onRetry {
                    await viewModel.loadData(currentShow: nil)
                }
        case .loading:
            LoaderView()
        case .error:
            MessageRetryView(imageName: "error", message: Localize.string(key: "genericErrorMessage"))
                .onRetry {
                    await viewModel.loadData(currentShow: nil)
                }
        case let .ready(shows):
            loadContent(shows)
        default:
            EmptyView()
        }
    }
}

// MARK: - Sub views

private extension ListShowsView {
    func loadContent(_ shows: [Show]) -> some View {
        NavigationStack {
            GeometryReader { geo in
                List {
                    ForEach(shows, id: \.id) { show in
                        ShowView(data: show,
                                  imageSize: geo.size.width * 0.25)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                        .onTapGesture {
                            viewModel.selectedShow = show
                        }
                        .task {
                            await viewModel.loadData(currentShow: show)
                        }
                        
                        if viewModel.shouldShowLoadMore(currentShow: show) {
                            LoaderView()
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
                .onAppear {
                    Task {
                        viewModel.updateFavorites()
                    }
                }
                .searchable(text: $viewModel.search)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            viewModel.openFavorites()
                        }) {
                            Text(Localize.string(key: "favorites"))
                                .foregroundStyle(Colors.StrongGray.swiftUI)
                        }
                    }
                }
            }
        }
    }
}
