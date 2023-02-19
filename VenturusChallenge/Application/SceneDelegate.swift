//
//  SceneDelegate.swift
//  VenturusChallenge
//
//  Created by Marcelo Carvalho on 14/02/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = PhotoGalleryViewControllerBuilder.make()
        window?.makeKeyAndVisible()
    }
}

