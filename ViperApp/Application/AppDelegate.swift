//
//  AppDelegate.swift
//  ViperApp
//
//  Created by Yasir Khan on 15/07/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainVC = ListingRouter.createModule()
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
        return true
    }
}
