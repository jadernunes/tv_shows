//
//  FavoritesView.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 08/04/24.
//

import SwiftUI
import Localization

struct FavoritesView<ViewModel: IFavoritesViewModel>: View {
    
    // MARK: - Properties
    
    typealias Strings = FavoritesStrings
    
    @ObservedObject private var viewModel: ViewModel

    // MARK: - Life cycle
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        switch viewModel.state {
        case .empty:
            MessageRetryView(imageName: "noData", message: GeneralStrings.noData.localized())
                .onRetry {
                    await viewModel.loadData()
                }
        case .loading:
            LoaderView()
        case let .error(message):
            MessageRetryView(imageName: "error", message: message)
                .onRetry {
                    await viewModel.loadData()
                }
        case let .ready(shows):
            loadContent(shows)
        default:
            EmptyView()
        }
    }
}

// MARK: - Sub views

private extension FavoritesView {
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
                    }
                    .onDelete { index in
                        if let index = index.first {
                            Task {
                                await viewModel.delete(index: index)
                            }
                        }
                    }
                }
                .onAppear {
                    Task {
                        await viewModel.loadData()
                    }
                }
                .toolbar {
                    EditButton().foregroundStyle(Colors.StrongGray.swiftUI)
                }
                .navigationTitle(Strings.title.localized())
                .navigationBarTitleDisplayMode(.inline)
                .listStyle(.plain)
                .frame(maxWidth: .infinity)
            }
        }
    }
}
