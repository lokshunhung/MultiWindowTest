//
//  AppDelegate.swift
//  MultiWindow
//
//  Created by LS Hung on 29/11/2023.
//

import UIKit
import os.log

final class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Logger.app.info(#function)

        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        Logger.app.info(#function)

        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return .from(connectingSceneSession: connectingSceneSession, options: options)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        Logger.app.info(#function)

        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

private extension UISceneConfiguration {
    static func from(connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sessionRole = connectingSceneSession.role
        let userActivity = options.userActivities.first ?? connectingSceneSession.stateRestorationActivity
        let userActivityType = userActivity?.activityType

        switch (sessionRole: sessionRole, userActivityType: userActivityType) {

        case (sessionRole: .windowApplication, userActivityType: "Open Secondary"):
            let userInfo: [String: Any] = [
                "NSUserActivityType": "Open Secondary",
            ]
            connectingSceneSession.userInfo = (connectingSceneSession.userInfo ?? [:])
                .merging(userInfo, uniquingKeysWith: { $1 })
            let config = UISceneConfiguration(name: nil, sessionRole: .windowApplication)
            config.delegateClass = SceneDelegate.self
            return config

        default:
            return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)

        }
    }
}

private extension Logger {
    static let app: Self = .init(
        subsystem: Bundle.main.bundleIdentifier!,
        category: "app")
}
