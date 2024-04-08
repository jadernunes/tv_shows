//
//  MessageRetryView.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 04/04/24.
//

import Combine
import SwiftUI

struct MessageRetryView: View {
    
    // MARK: - Properties
    
    private let imageName: String
    private let message: String
    private var onRetry: (() async -> Void) = {}
    
    // MARK: - Life cycle
    
    init(imageName: String = "", message: String = "", onRetry: @escaping (() async -> Void) = {}) {
        self.imageName = imageName
        self.message = message
        self.onRetry = onRetry
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width * 0.5, height: geo.size.width * 0.5)
                Text(message)
                    .font(Fonts.semibold16)
                Button(Localize.string(key: "retry")) {
                    Task {
                        await onRetry()
                    }
                }
                .frame(width: 100, height: 44)
                .foregroundColor(Colors.CustomWhite.swiftUI)
                .background(Colors.StrongGray.swiftUI)
                .cornerRadius(8)
                .padding(.top, 30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
    
    // MARK: - Methods
    
    func onRetry(_ callback: @escaping (() async -> Void)) -> some View {
        MessageRetryView(imageName: imageName, message: message, onRetry: callback)
    }
}
