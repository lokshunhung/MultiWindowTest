//
//  Router+App.swift
//  MultiWindow
//
//  Created by LS Hung on 29/11/2023.
//

import UIKit

extension Router {
    static func appRouter() -> Router {
        var router: Router!
        router = Router.Builder()
            .register(ViewControllerRoute.self) { route in
                ViewController(router: router)
            }
            .register(SecondaryViewControllerRoute.self) { route in
                SecondaryViewController(router: router)
            }
            .build()
        return router
    }
}
