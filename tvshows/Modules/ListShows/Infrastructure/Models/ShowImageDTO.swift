//
//  ShowImageDTO.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import Foundation

struct ShowImageDTO:  Decodable {
    let medium: URL?
    let original: URL?
    
    init(medium: URL?, original: URL?) {
        self.medium = medium
        self.original = original
    }
    
    init(showImage: ShowImage?) {
        self.init(
            medium: showImage?.medium,
            original: showImage?.original)
    }
    
    var asShowImage: ShowImage {
        ShowImage(
            medium: medium,
            original: original)
    }
}

// MARK: - ObjectRepresentable

extension ShowImageDTO: ObjectRepresentable {
    static var key: String { "ShowImageDTO" }
}
