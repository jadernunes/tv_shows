//
//  Collection+Extension.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 08/04/24.
//

import Foundation

extension Collection {
    
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    public subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
