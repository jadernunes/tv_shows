//
//  ShowDetailState.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 07/04/24.
//

enum ShowDetailState: Equatable {
    case idle, error(message: String), loading, empty, ready(show: Show, seasons: [Season])

    static func == (lhs: ShowDetailState, rhs: ShowDetailState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.error, .error), (.loading, .loading), (.empty, .empty):
            return true
        case let (.ready(show1, seasons1), .ready(show2, seasons2)):
            return seasons1 == seasons2 && show1 == show2
        default:
            return false
        }
    }
}
