//
//  HomeTabBarController.swift
//  CSMovies
//
//  Created by Amanda Calcic on 25/11/22.
//

import UIKit

class HomeTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarController()
    }
    
    private func setupTabBarController() {
        
        let nowPlayingViewController = UINavigationController(rootViewController: NowPlayingMoviesViewController(viewModel: NowPlayingMoviesViewModel()))
        
        self.setViewControllers([nowPlayingViewController], animated: false)
    }
}
