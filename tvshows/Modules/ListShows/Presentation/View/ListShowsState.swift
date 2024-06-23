//
//  ListShowsState.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import Foundation

enum ListShowsState: Equatable {
    case idle, error(message: String), loading, empty, ready(shows: [Show])

    static func == (lhs: ListShowsState, rhs: ListShowsState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.error, .error), (.loading, .loading), (.empty, .empty):
            return true
        case let (.ready(shows1), .ready(shows2)):
            return shows1 == shows2
        default:
            return false
        }
    }
}
