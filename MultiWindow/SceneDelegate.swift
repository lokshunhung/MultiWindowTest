//
//  SceneDelegate.swift
//  MultiWindow
//
//  Created by LS Hung on 29/11/2023.
//

import UIKit
import os.log

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let router: Router = .appRouter()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        Logger.scene.info(#function)

        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        defer { self.window = window }

        let rootViewController = router.rootViewController(for: session)
        let navigation = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        Logger.scene.info(#function)

        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        Logger.scene.info(#function)

        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        Logger.scene.info(#function)

        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        Logger.scene.info(#function)

        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        Logger.scene.info(#function)

        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}

private extension Router {
    func rootViewController(for session: UISceneSession) -> UIViewController {
        switch session.userInfo?["NSUserActivityType"] as? String {

        case "Open Secondary":
            return self.lookup(SecondaryViewControllerRoute())

        default:
            return self.lookup(ViewControllerRoute())

        }
    }
}

private extension Logger {
    static let scene: Self = .init(
        subsystem: Bundle.main.bundleIdentifier!,
        category: "scene")
}
