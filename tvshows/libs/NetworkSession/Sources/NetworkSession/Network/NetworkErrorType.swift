//
//  NetworkErrorType.swift
//
//  Created by Jader Nunes on 22/06/24.
//

public enum NetworkErrorType: Error {
    case missingURL
    case jsonEncodingFailed(error: Error)
    case noInternet
    case generic
    
    public var message: String {
        switch self {
        case .missingURL:
            localizedDescription
            
        case let .jsonEncodingFailed(error):
            error.localizedDescription
            
        case .noInternet:
            NetworkSessionStrings.noInternetError.localized()
            
        case .generic:
            NetworkSessionStrings.genericError.localized()
        }
    }
}
