//
//  Router.swift
//  MultiWindow
//
//  Created by LS Hung on 29/11/2023.
//

import UIKit

protocol Route: AnyObject {}

final class Router {
    private let routes: [ObjectIdentifier: (any Route) -> UIViewController]

    private init(routes: [ObjectIdentifier: (any Route) -> UIViewController]) {
        self.routes = routes
    }

    func lookup<R: Route>(_ route: R) -> UIViewController {
        let key = ObjectIdentifier(R.self)
        guard let factory = routes[key] else {
            fatalError("\(R.self) is not registered")
        }
        return factory(route)
    }
}

extension Router {
    final class Builder {
        private var routes: [ObjectIdentifier: (any Route) -> UIViewController] = [:]

        init() {}

        func register<R: Route>(
            _: R.Type,
            _ factory: @escaping (_ route: R) -> UIViewController
        ) -> Self {
            let key = ObjectIdentifier(R.self)
            guard routes[key] == nil else {
                fatalError("\(R.self) already registered")
            }
            routes[key] = { (route: Route) in
                factory(route as! R)
            }
            return self
        }

        func build() -> Router {
            return .init(routes: routes)
        }
    }
}
