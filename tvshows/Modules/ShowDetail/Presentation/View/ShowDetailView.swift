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
        GeometryReader { geo in
            ScrollView {
                HStack {
                    VStack(alignment: .center) {
                        titleView
                        imageShow(screenWidth: geo.size.width)
                        Divider()
                            .padding(.top, 16)
                            .padding(.bottom, 16)
                        timeContentView
                        daysContentView
                        genresContentView
                        summaryView
                            .frame(maxWidth: .infinity)
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .padding(16)
    }
}

// MARK: - Subview

private extension ShowDetailView {
    
    var titleView: some View {
        Text(viewModel.show.name)
            .font(Fonts.semibold24)
            .foregroundStyle(Colors.StrongGray.swiftUI)
            .padding(.bottom, 8)
    }
    
    @ViewBuilder
    func imageShow(screenWidth: CGFloat) -> some View {
        if let url = viewModel.show.image?.original {
            CacheAsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    LoaderView()
                case .success(let image):
                    imageWithStyle(image: image, screenWidth: screenWidth)
                case .failure:
                    imageWithStyle(image: Images.NoImage.image, screenWidth: screenWidth)
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            imageWithStyle(image: Images.NoImage.image, screenWidth: screenWidth)
        }
    }
    
    func imageWithStyle(image: Image, screenWidth: CGFloat) -> some View {
        image
            .resizable()
            .cornerRadius(8)
            .aspectRatio(contentMode: .fit)
            .frame(width: screenWidth, height: screenWidth * 0.7)
    }
    
    var summaryView: some View {
        HTMLStringView(htmlContent: viewModel.show.summary ?? "")
            .padding(.bottom, 8)
    }
    
    var timeContentView: some View {
        HStack {
            Text(Localize.string(key: "time") + ": ")
                .font(Fonts.regular12)
                .foregroundStyle(Colors.StrongGray.swiftUI)
                .padding(.bottom, 8)
            Text(viewModel.show.schedule?.time ?? "")
                .font(Fonts.thin12)
                .foregroundStyle(Colors.StrongGray.swiftUI)
                .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    var daysContentView: some View {
        let days = viewModel.show.schedule?.days.joined(separator: ", ")
        HStack {
            Text(Localize.string(key: "days") + ": ")
                .font(Fonts.regular12)
                .foregroundStyle(Colors.StrongGray.swiftUI)
                .padding(.bottom, 8)
            Text(days ?? "")
                .font(Fonts.thin12)
                .foregroundStyle(Colors.StrongGray.swiftUI)
                .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    var genresContentView: some View {
        let days = viewModel.show.genres?.joined(separator: ", ")
        HStack {
            Text(Localize.string(key: "genres") + ": ")
                .font(Fonts.regular12)
                .foregroundStyle(Colors.StrongGray.swiftUI)
                .padding(.bottom, 8)
            Text(days ?? "")
                .font(Fonts.thin12)
                .foregroundStyle(Colors.StrongGray.swiftUI)
                .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
