//
//  ShowView.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import SwiftUI

struct ShowView: View {
    
    // MARK: - Properties
    
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
    
    private func imageWithStyle(image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: imageSize, height: imageSize)
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
                    LoaderView()
                case .success(let image):
                    imageWithStyle(image: image)
                case .failure:
                    imageWithStyle(image: Images.NoImage.image)
                @unknown default:
                    EmptyView()
                }
            }
            .cornerRadius(8)
        } else {
            imageWithStyle(image: Images.NoImage.image)
        }
    }
    
    var titleView: some View {
        Text(data.name)
            .lineLimit(2)
            .foregroundStyle(Colors.StrongGray.swiftUI)
            .padding(.bottom, 8)
    }
    
    @ViewBuilder
    var languageView: some View {
        HStack {
            Text(Localize.string(key: "language.title") + ": ")
                .font(Fonts.regular12)
                .foregroundStyle(Colors.MediumGray.swiftUI)
            Text(languageText)
                .font(Fonts.thin12)
                .foregroundStyle(Colors.MediumGray.swiftUI)
                .lineLimit(2)
        }
    }
    
    var languageText: String {
        guard let language = data.language else {
            return Localize.string(key: "notMentioned")
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
