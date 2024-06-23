//
//  ShowView.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import SwiftUI
import Localization

struct ShowView: View {
    
    // MARK: - Properties
    
    typealias Strings = ListShowsStrings
    
    private let data: Show
    private let imageSize: CGFloat
    
    // MARK: - Life cycle
    
    init(data: Show, imageSize: CGFloat) {
        self.data = data
        self.imageSize = imageSize
    }
    
    var body: some View {
        HStack {
            HStack {
                imageView
                VStack(alignment: .leading) {
                    titleView
                    languageView
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.vertical, 8)
                .padding(.trailing, 8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .cornerRadius(8)
            .background(Colors.CustomWhite.swiftUI.clipShape(RoundedRectangle(cornerRadius:8)))
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .overlay(showBoarder)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: - Methods
    
    private func imageWithStyle(image: Image, contentMode: ContentMode = .fit) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: contentMode)
            .frame(width: imageSize, height: imageSize*1.5)
    }
}

// MARK: - Elements

private extension ShowView {
    @ViewBuilder
    var imageView: some View {
        if let url = data.image?.medium {
            CacheAsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    LoaderView(size: .small)
                        .frame(width: imageSize, height: imageSize*1.5)
                case .success(let image):
                    imageWithStyle(image: image, contentMode: .fill)
                case .failure:
                    imageWithStyle(image: Images.NoImage.image)
                        .frame(width: imageSize, height: imageSize*1.5)
                @unknown default:
                    EmptyView()
                }
            }
            .cornerRadius(8)
        } else {
            imageWithStyle(image: Images.NoImage.image)
                .frame(width: imageSize, height: imageSize*1.5)
        }
    }
    
    var titleView: some View {
        Text(data.name)
            .lineLimit(2)
            .font(Fonts.semibold16)
            .foregroundStyle(Colors.StrongGray.swiftUI)
            .padding(.bottom, 8)
    }
    
    @ViewBuilder
    var languageView: some View {
        HStack {
            Text(Strings.languageTitle.localized() + ": ")
                .font(Fonts.bold12)
                .foregroundStyle(Colors.MediumGray.swiftUI)
            Text(languageText)
                .font(Fonts.regular12)
                .foregroundStyle(Colors.MediumGray.swiftUI)
                .lineLimit(2)
        }
    }
    
    var languageText: String {
        guard let language = data.language else {
            return Strings.notMentioned.localized()
        }
        
        return language
    }
    
    var showBoarder: some View {
        RoundedRectangle(cornerRadius: 16)
            .stroke(.black.opacity(0.1), lineWidth: 1)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
    }
}
