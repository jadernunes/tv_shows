//
//  ListShowsResources.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

enum ListShowsResources {
    case loadAll(page: Int)
}

extension ListShowsResources: Requestable {
    
    var method: HTTPMethodType {
        switch self {
        case .loadAll:
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
        }
    }
    
    var path: String {
        switch self {
        case .loadAll:
            return "/shows"
        }
    }
}
