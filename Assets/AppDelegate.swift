//
//  AppDelegate.swift
//  CSMovies
//
//  Created by Amanda Calcic on 10/11/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        let navigationController = UINavigationController(rootViewController: NowPlayingMoviesViewController(viewModel: NowPlayingMoviesViewModel()))
        window?.rootViewController = navigationController
        
        return true
    }
}

