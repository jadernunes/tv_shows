//
//  DateFormatter+Extension.swift
//
//  Created by Jader Nunes on 23/06/24.
//

import Foundation

extension DateFormatter {

    static let dateFormatterReceived: DateFormatter = {
        $0.dateFormat = DateFormatType.serverShort.rawValue
        return $0
    }(DateFormatter())
}
