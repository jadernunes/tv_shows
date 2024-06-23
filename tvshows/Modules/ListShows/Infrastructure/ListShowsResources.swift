//
//  ListShowsResources.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import NetworkSession

enum ListShowsResources {
    case loadAll(page: Int)
    case search(text: String)
}

extension ListShowsResources: Requestable {
    
    var method: HTTPMethodType {
        switch self {
        case .loadAll, .search:
            return .get
        }
    }
    
    var parameters: Params? {
        switch self {
        case let .loadAll(page):
            let params: [String: Any] = [
                "page": page
            ]
            
            return params
        case let .search(text):
            let params: [String: Any] = [
                "q": text
            ]
            
            return params
        }
    }
    
    var path: String {
        switch self {
        case .loadAll:
            return "/shows"
        case .search:
            return "/search/shows"
        }
    }
}
