//
//  EpisodeDTO.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 04/04/24.
//

import Foundation

struct EpisodeDTO:  Decodable {
    let id: Int
    let name: String
    let season: Int
    let number: Int
    let summary: String?
    let image: ShowImageDTO?
    
    var asEpisode: Episode {
        Episode(
            id: id,
            name: name,
            season: season,
            number: number,
            summary: summary,
            image: image?.asShowImage)
    }
}
