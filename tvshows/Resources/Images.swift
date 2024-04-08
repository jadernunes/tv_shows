//
//  Images.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import SwiftUI

struct Images {
    
    struct NoImage {
        static let uiImage = UIImage(named: "noImage") ?? .no
        static let image = Image(uiImage: uiImage)
    }
    
    struct Close {
        static let uiImage = UIImage(named: "close") ?? .no
        static let image = Image(uiImage: uiImage)
    }
}
