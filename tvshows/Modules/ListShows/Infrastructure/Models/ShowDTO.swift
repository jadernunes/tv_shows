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
    
    var asShow: Show {
        Show(id: id, name: name)
    }
}
