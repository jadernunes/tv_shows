//
//  LocalizableString.swift
//
//
//  Created by Jader Nunes on 22/06/24.
//

import Foundation

/// It uses the Localizable.strings file
///```swift
/// var string: String
/// func string(_ values: CVarArg...) -> String
/// ```
public protocol LocalizableString: RawRepresentable, CaseIterable where RawValue == String {}
public extension LocalizableString {
    
    /// - Important: This uses the `Bundle.main` as default
    /// ```
    /// Strings.title.localized
    /// ```
    func localized(bundle: Bundle = .main) -> String {
        let textLocalized = NSLocalizedString(rawValue, bundle: bundle, comment: "")
        return rawValue == textLocalized ? rawValue : textLocalized
    }
    
    /// - Important: This uses the `Bundle.main` as default
    ///
    /// Localize a given `key` with a list of string format values.
    /// # Usage
    /// In the localizable file we can have a key i.g.:
    ///```swift
    /// "person_info" = "Name: %@, Country: %@";
    /// ```
    /// How to use it
    /// ```swift
    /// Strings.personalInfo.localized("Jader", "Brazil")
    /// //Name: Jader, Country: Brazil
    /// ```
    func localized(_ values: CVarArg..., bundle: Bundle = .main) -> String {
        let numberOfArgs = localized(bundle: bundle).components(separatedBy: "%@").count - 1
        
        guard localized(bundle: bundle).isEmpty == false, numberOfArgs == values.count  else {
            assertionFailure("Number of arguments isn't equal do the number of values")
            return localized(bundle: bundle)
        }
        
        return String(format: localized(bundle: bundle), arguments: values)
    }
}
