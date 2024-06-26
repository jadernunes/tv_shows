//
//  AppDelegate.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setUpNavigationStyle()
        return true
    }

    // MARK: - UISceneSession Life cycle

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    private func setUpNavigationStyle() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: Colors.StrongGray.uikit ]
        UINavigationBar.appearance().tintColor = Colors.StrongGray.uikit
    }
}
