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
    
    var asShowImage: ShowImage {
        ShowImage(
            medium: medium,
            original: original)
    }
}
