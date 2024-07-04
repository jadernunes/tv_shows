//
//  ShowDetailView.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 04/04/24.
//

import SwiftUI
import Localization

struct ShowDetailView<ViewModel: IShowDetailViewModel>: View {
    
    // MARK: - Properties
    
    typealias Strings = ShowDetailStrings
    
    @ObservedObject private var viewModel: ViewModel
    
    // MARK: - Life cycle
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geo in
            
            switch viewModel.state {
            case .idle:
                EmptyView()
            case let .error(message):
                MessageRetryView(imageName: "error", message: message)
                    .onRetry {
                        await viewModel.loadData()
                    }
            case .empty:
                MessageRetryView(imageName: "noData", message: GeneralStrings.noData.localized())
                    .onRetry {
                        await viewModel.loadData()
                    }
            case .loading:
                LoaderView()
            case let .ready(show, seasons):
                successContent(show: show, seasons: seasons, screeSize: geo.size)
            }
        }
        .padding(16)
    }
}

// MARK: - Subview

private extension ShowDetailView {
    
    @ViewBuilder
    func successContent(show: Show, seasons: [Season], screeSize: CGSize) -> some View {
        List {
            VStack(alignment: .center) {
                imageShow(image: show.image, width: screeSize.width, height: screeSize.width * 0.6)
                Divider()
                    .padding(.vertical, 16)
                timeContentView(time: show.schedule?.time ?? "")
                daysContentView(days: show.schedule?.days ?? [])
                genresContentView(genres: show.genres ?? [])
                summaryView(summary: show.summary?.stripHTML ?? "")
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .listRowSeparator(.hidden)
            
            ForEach(seasons, id: \.id) { season in
                seasonView(season: season, screenWidth: screeSize.width)
            }
        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
        .navigationTitle(show.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    viewModel.updateFavorite()
                }) {
                    favoriteImage(show)
                }
            }
        }
    }
    
    func favoriteImage(_ show: Show) -> some View {
        let image = show.isFavorite ? Images.FavoriteFull.image : Images.FavoriteEmpty.image
        return image
            .resizable()
            .tint(Colors.StrongGray.swiftUI)
            .frame(width: 20, height: 20)
    }
    
    @ViewBuilder
    func seasonTitle(_ title: String) -> some View {
        Text(EpisodeDetailStrings.season.localized() + " \(title)")
            .font(Fonts.semibold16)
            .foregroundStyle(Colors.StrongGray.swiftUI)
    }
    
    @ViewBuilder
    func seasonView(season: Season, screenWidth: CGFloat) -> some View {
        Section(header: seasonTitle("\(season.id)")) {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(season.episodes, id: \.id) { episode in
                        episodeView(episode: episode, screenWidth: screenWidth)
                            .padding(.horizontal, 4)
                            .onTapGesture {
                                viewModel.selectedEpisode = episode
                            }
                    }
                }
            }
            
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
    }
    
    @ViewBuilder
    func episodeView(episode: Episode, screenWidth: CGFloat) -> some View {
        VStack(alignment: .center) {
            imageShow(image: episode.image, width: screenWidth * 0.3, height: screenWidth * 0.21)
            Text("\(episode.number) - " + episode.name)
                .lineLimit(1)
                .font(Fonts.regular12)
                .foregroundStyle(Colors.StrongGray.swiftUI)
                .padding(.bottom, 2)
                .padding(.horizontal, 2)
                .frame(width: screenWidth * 0.3, alignment: .leading)
        }
        .frame(width: screenWidth * 0.32)
        .padding(.bottom, 16)
    }
    
    @ViewBuilder
    func imageShow(image: ShowImage?, width: CGFloat, height: CGFloat) -> some View {
        if let url = image?.original {
            CacheAsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    LoaderView(size: .regular)
                        .cornerRadius(8)
                        .frame(width: width, height: height)
                case .success(let image):
                    imageWithStyle(image: image, width: width, height:height)
                case .failure:
                    imageWithStyle(image: Images.NoImage.image, width: width, height:height)
                        .padding(.vertical, 2)
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            imageWithStyle(image: Images.NoImage.image, width: width, height:height)
                .padding(.vertical, 2)
        }
    }
    
    func imageWithStyle(image: Image, width: CGFloat, height: CGFloat) -> some View {
        image
            .resizable()
            .cornerRadius(8)
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: height)
    }
    
    @ViewBuilder
    func summaryView(summary: String) -> some View {
        Text(EpisodeDetailStrings.summary.localized() + ":")
            .font(Fonts.bold12)
            .foregroundStyle(Colors.StrongGray.swiftUI)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 8)
        Text(summary)
            .font(Fonts.regular12)
            .foregroundStyle(Colors.StrongGray.swiftUI)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 8)
    }
    
    func timeContentView(time: String) -> some View {
        HStack {
            Text(Strings.time.localized() + ": ")
                .font(Fonts.bold12)
                .foregroundStyle(Colors.StrongGray.swiftUI)
                .padding(.bottom, 8)
            Text(time)
                .font(Fonts.regular12)
                .foregroundStyle(Colors.StrongGray.swiftUI)
                .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    func daysContentView(days: [String]) -> some View {
        let days = days.joined(separator: ", ")
        HStack {
            Text(Strings.days.localized() + ": ")
                .font(Fonts.bold12)
                .foregroundStyle(Colors.StrongGray.swiftUI)
                .padding(.bottom, 8)
            Text(days)
                .font(Fonts.regular12)
                .foregroundStyle(Colors.StrongGray.swiftUI)
                .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    func genresContentView(genres: [String]) -> some View {
        let days = genres.joined(separator: ", ")
        HStack {
            Text(Strings.genres.localized() + ": ")
                .font(Fonts.bold12)
                .foregroundStyle(Colors.StrongGray.swiftUI)
                .padding(.bottom, 8)
            Text(days)
                .font(Fonts.regular12)
                .foregroundStyle(Colors.StrongGray.swiftUI)
                .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var showBoarder: some View {
        RoundedRectangle(cornerRadius: 8)
            .stroke(.black.opacity(0.1), lineWidth: 1)
            .padding(.vertical, 7)
    }
}
