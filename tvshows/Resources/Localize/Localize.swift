//
//  Localize.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import Foundation

struct Localize {
    
    static func string(key: String) -> String {
        let textLocalised = NSLocalizedString(key, comment: "")
        return key == textLocalised ? "" : textLocalised
    }
}
