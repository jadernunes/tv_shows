//
//  LocalizableString+Extension.swift
//
//
//  Created by Jader Nunes on 22/06/24.
//

import Localization

extension LocalizableString {
    
    func localized() -> String {
        localized(bundle: .module)
    }
    
    func localized(_ values: CVarArg...) -> String {
        localized(values, bundle: .module)
    }
}
