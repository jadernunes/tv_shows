//
//  String+Extension.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 05/04/24.
//

extension String {
    var stripHTML: String {
        replacingOccurrences(
            of: "<[^>]+>",
            with: "",
            options: .regularExpression)
    }
}
