//
//  Router+App.swift
//  MultiWindow
//
//  Created by LS Hung on 29/11/2023.
//

import UIKit

extension Router {
    static let app = appRouter()

    private static func appRouter() -> Router {
        Router.Builder()
            .register(ViewControllerRoute.self) { route in
                let viewController = ViewController(nibName: nil, bundle: nil)
                let navigation = UINavigationController(rootViewController: viewController)
                navigation.navigationBar.prefersLargeTitles = true
                return navigation
            }
            .build()
    }
}
