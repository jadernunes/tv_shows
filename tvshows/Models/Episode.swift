//
//  Episode.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 04/04/24.
//

struct Episode: Equatable {
    let id: Int
    let name: String
    let season: Int
    let number: Int
    let summary: String?
    let image: ShowImage?
}
