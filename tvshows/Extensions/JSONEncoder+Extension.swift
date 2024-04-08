//
//  JSONEncoder+Extension.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import Foundation

extension JSONEncoder {

    static let encoder: JSONEncoder = {
        $0.dateEncodingStrategy = .formatted(.dateFormatterReveiced)
        return $0
    }(JSONEncoder())
}
