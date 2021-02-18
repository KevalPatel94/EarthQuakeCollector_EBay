//
//  SceneDelegate.swift
//  EarthQuakeCollector
//
//  Created by Keval Patel on 2/16/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    @available(iOS 13.0, *)
    class SceneDelegate: UIResponder, UIWindowSceneDelegate {
        var window: UIWindow?

        func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = (scene as? UIWindowScene) else { return }

            let window = UIWindow(windowScene: windowScene)
            self.window = window
        }

        func sceneDidDisconnect(_ scene: UIScene) {
            // Called as the scene is being released by the system.
        }

        func sceneDidBecomeActive(_ scene: UIScene) {
            // Not called under iOS 12 - See AppDelegate applicationDidBecomeActive
        }

        func sceneWillResignActive(_ scene: UIScene) {
            // Not called under iOS 12 - See AppDelegate applicationWillResignActive
        }

        func sceneWillEnterForeground(_ scene: UIScene) {
            // Not called under iOS 12 - See AppDelegate applicationWillEnterForeground
        }

        func sceneDidEnterBackground(_ scene: UIScene) {
            // Not called under iOS 12 - See AppDelegate applicationDidEnterBackground
        }
    }


}

