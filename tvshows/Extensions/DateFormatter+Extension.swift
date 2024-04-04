//
//  DateFormatter+Extension.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import Foundation

extension DateFormatter {

    static let dateFormatterReveiced: DateFormatter = {
        $0.dateFormat = DateFormatType.serverShort.rawValue
        return $0
    }(DateFormatter())
}
