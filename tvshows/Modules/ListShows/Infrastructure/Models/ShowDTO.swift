//
//  ShowDTO.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import Foundation

struct ShowDTO: Decodable {
    let id: Int
    let name: String
    let language: String?
    let image: ShowImageDTO?
    let summary: String?
    
    var asShow: Show {
        Show(
            id: id,
            name: name,
            language: language,
            image: image?.asShowImage,
            summary: summary)
    }
}
