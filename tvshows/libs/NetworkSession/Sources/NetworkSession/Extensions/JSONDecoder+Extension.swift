//
//  JSONDecoder+Extension.swift
//
//  Created by Jader Nunes on 23/06/24.
//

import Foundation

extension JSONDecoder {

    static let decoder: JSONDecoder = {
        $0.dateDecodingStrategy = .formatted(.dateFormatterReceived)
        return $0
    }(JSONDecoder())
}
