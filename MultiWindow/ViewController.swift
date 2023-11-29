//
//  ViewController.swift
//  MultiWindow
//
//  Created by LS Hung on 29/11/2023.
//

import UIKit
import os.log

final class ViewControllerRoute: Route {}

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
            let viewController = self.router.lookup(SecondaryViewControllerRoute())
            self.show(viewController, sender: self)
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

}

private extension Logger {
    static let viewController: Self = .init(
        subsystem: Bundle.main.bundleIdentifier!,
        category: "viewController")
}

