//
//  EpisodeDetailView.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 05/04/24.
//

import SwiftUI
import Localization

struct EpisodeDetailView<ViewModel: IEpisodeDetailViewModel>: View {
    
    // MARK: - Properties
    
    typealias Strings = EpisodeDetailStrings
    
    @ObservedObject private var viewModel: ViewModel
    
    // MARK: - Life cycle
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                ScrollView {
                    VStack(alignment: .center) {
                        imageShow(
                            image: viewModel.episode.image,
                            width: geo.size.width,
                            height: geo.size.width * 0.6)
                        Divider()
                            .padding(.vertical, 16)
                        
                        detailItemView(title: Strings.number.localized(), content: "\(viewModel.episode.number)")
                        detailItemView(title: Strings.season.localized(), content: "\(viewModel.episode.season)")
                        summaryView(summary: viewModel.episode.summary?.stripHTML ?? "")
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .listRowSeparator(.hidden)
                }
            }
            .navigationTitle(viewModel.episode.name)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        viewModel.close()
                    }) {
                        Images.Close.image
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                }
            }
        }
        .padding(16)
    }
}

// MARK: - Subviews

private extension EpisodeDetailView {
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
    
    func detailItemView(title: String, content: String) -> some View {
        HStack {
            Text(title + ": ")
                .font(Fonts.bold12)
                .foregroundStyle(Colors.StrongGray.swiftUI)
                .padding(.bottom, 8)
            Text(content)
                .font(Fonts.regular12)
                .foregroundStyle(Colors.StrongGray.swiftUI)
                .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    func summaryView(summary: String) -> some View {
        Text(Strings.summary.localized() + ":")
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
}
