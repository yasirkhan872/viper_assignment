//
//  SceneDelegate.swift
//  ViperApp
//
//  Created by Yasir Khan on 15/07/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let mainVC = ListingRouter.createModule()
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
    }
}
