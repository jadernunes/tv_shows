//
//  CacheData.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import SwiftUI

// MARK: - CacheData

protocol ICacheData {
    var image: Image { get }
}

final class CacheData: ICacheData {
    
    // MARK: - Properties
    
    let image: Image
    
    // MARK: - Life cycle
    
    init(image: Image) {
        self.image = image
    }
}
