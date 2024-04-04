//
//  Config.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import UIKit

final class Config {

    // MARK: - Properties
    
    static var baseURL: String {
        configKey(key: "baseURL")
    }

    // MARK: - Methods

    private static func configKey(key: String) -> String {
        guard
            let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: path) as? [String: Any],
            let value = dictionary[key] as? String
        else { return "" }
        return value
    }
}
