//
//  JSONDecoder+Extension.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import Foundation

extension JSONDecoder {

    static let decoder: JSONDecoder = {
        $0.dateDecodingStrategy = .formatted(.dateFormatterReveiced)
        return $0
    }(JSONDecoder())
}
