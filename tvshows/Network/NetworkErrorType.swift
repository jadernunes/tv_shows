//
//  NetworkErrorType.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

enum NetworkErrorType: Error {
    case missingURL
    case jsonEncodingFailed(error: Error)
    case noInternet(message: String = "")
    case generic(message: String = "")
}
