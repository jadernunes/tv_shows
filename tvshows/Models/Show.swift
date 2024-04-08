//
//  Show.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import Foundation

struct Show: Equatable {
    let id: Int
    let name: String
    let language: String?
    let image: ShowImage?
    let summary: String?
    let schedule: Schedule?
    let genres: [String]?
}

