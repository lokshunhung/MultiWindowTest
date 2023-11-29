//
//  ViewController.swift
//  MultiWindow
//
//  Created by LS Hung on 29/11/2023.
//

import UIKit
import os.log

struct ViewControllerRoute: Route {}

final class ViewController: UIViewController {

    private let router: Router

    init(router: Router) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "View Controller"

        let button = newButton {
            Logger.viewController.info("clicked")
            self.openSecondaryInNewWindow()
        }
        view.addSubview(button)

        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    private func newButton(perform: @escaping () -> Void) -> some UIView {
        let button = UIButton(
            primaryAction: UIAction(handler: { action in perform() }))
        button.translatesAutoresizingMaskIntoConstraints = false
        var config: UIButton.Configuration = .filled()
        config.title = "Click me"
        button.configuration = config
        return button
    }

    private func openSecondaryInNewWindow() {
        let userActivity = NSUserActivity(activityType: "Open Secondary")
        let options = UIScene.ActivationRequestOptions()
        options.requestingScene = view.window?.windowScene

        if #available(iOS 17, *) {
            let request = UISceneSessionActivationRequest(
                role: .windowApplication,
                userActivity: userActivity,
                options: options)
            UIApplication.shared.activateSceneSession(
                for: request,
                errorHandler: nil)
        } else {
            UIApplication.shared.requestSceneSessionActivation(
                nil, // make a new scene session
                userActivity: userActivity,
                options: options,
                errorHandler: nil)
        }
    }
}

private extension Logger {
    static let viewController: Self = .init(
        subsystem: Bundle.main.bundleIdentifier!,
        category: "viewController")
}

