//
//  ObjectRepresentable.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 07/04/24.
//

import Foundation

protocol ObjectRepresentable: Codable {
    static var key: String { get }
}
