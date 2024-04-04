//
//  CacheAsyncImage.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import SwiftUI

fileprivate let storageImage = NSCache<NSString, CacheData>()

struct CacheAsyncImage<Content: View>: View {

    // MARK: - Properties
    
    typealias ContentBuilder = (AsyncImagePhase) -> Content
    
    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let storage: NSCache<NSString, CacheData>
    private let content: ContentBuilder
    
    // MARK: - Life cycle
    
    init(url: URL,
         scale: CGFloat = 1.0,
         transaction: Transaction = Transaction(),
         storage: NSCache<NSString, CacheData> = storageImage,
         @ViewBuilder content: @escaping ContentBuilder)  {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.storage = storage
        self.content = content
    }
    
    var body: some View {
        if let cached = storageImage.object(forKey: url.absoluteString as NSString) {
            content(.success(cached.image))
        } else {
            AsyncImage(
                url: url,
                scale: scale,
                transaction: transaction,
                content: { cacheAndRender(phase: $0) })
        }
    }
    
    // MARK: - Methods

    private func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            storageImage.setObject(CacheData(image: image), forKey: url.absoluteString as NSString)
        }

        return content(phase)
    }
}
