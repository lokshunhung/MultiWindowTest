//
//  SecondaryViewController.swift
//  MultiWindow
//
//  Created by LS Hung on 29/11/2023.
//

import UIKit
import OSLog

struct SecondaryViewControllerRoute: Route {}

final class SecondaryViewController: UIViewController {

    private let router: Router

    init(router: Router) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Secondary"
    }

}

private extension Logger {
    static let secondary: Self = .init(
        subsystem: Bundle.main.bundleIdentifier!,
        category: "secondary")
}
