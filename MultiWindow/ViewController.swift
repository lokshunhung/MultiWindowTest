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

        let newWindowButton = newButton(title: "Open in new window") {
            Logger.viewController.info("clicked new window")
            self.openSecondaryInNewWindow()
        }
        view.addSubview(newWindowButton)

        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: newWindowButton.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: newWindowButton.centerYAnchor),
            newWindowButton.widthAnchor.constraint(equalToConstant: 200),
            newWindowButton.heightAnchor.constraint(equalToConstant: 50),
        ])

        let navigateButton = newButton(title: "Navigate") {
            Logger.viewController.info("clicked navigate")
            let viewController = self.router.lookup(SecondaryViewControllerRoute())
            self.show(viewController, sender: self)
        }
        view.addSubview(navigateButton)

        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: navigateButton.centerXAnchor),
            newWindowButton.bottomAnchor.constraint(equalTo: navigateButton.topAnchor, constant: -20),
            navigateButton.widthAnchor.constraint(equalToConstant: 200),
            navigateButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    private func newButton(title: String, perform: @escaping () -> Void) -> some UIView {
        let button = UIButton(
            primaryAction: UIAction(handler: { action in perform() }))
        button.translatesAutoresizingMaskIntoConstraints = false
        var config: UIButton.Configuration = .filled()
        config.title = title
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

