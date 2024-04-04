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
                VStack(alignment: .leading) {
                    titleView
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
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: - Methods
    
    private func imageWithStyle(image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}

// MARK: - Elements

private extension ShowView {
    var titleView: some View {
        Text(data.name)
            .lineLimit(2)
            .foregroundStyle(Colors.StrongGray.swiftUI)
            .padding(.bottom, 8)
    }
}
