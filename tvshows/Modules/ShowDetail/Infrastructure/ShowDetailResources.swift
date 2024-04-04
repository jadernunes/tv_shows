//
//  ShowDetailResources.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 04/04/24.
//

enum ShowDetailResources {
    case loadEpisodes(showID: Int)
}

extension ShowDetailResources: Requestable {
    
    var method: HTTPMethodType {
        switch self {
        case .loadEpisodes:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case let .loadEpisodes(showID):
            return "/shows/\(showID)/episodes"
        }
    }
}
