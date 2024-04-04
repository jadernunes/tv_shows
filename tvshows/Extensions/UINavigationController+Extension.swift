//
//  UINavigationController+Extension.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 04/04/24.
//

import UIKit

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        navigationBar
            .topItem?
            .backBarButtonItem = UIBarButtonItem(
                title: "",
                style: .plain,
                target: nil,
                action: nil)
    }
}
