//
//  MVTabBarController.swift
//  Movies
//
//  Created by Allan Melo on 13/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit

class MVTabBarController: UITabBarController, UITabBarControllerDelegate {

    static let shared = MVTabBarController()

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self

        setupAppearance()
        createTabs()
    }

    func currentNavigation() -> UINavigationController? {
        return selectedViewController as? UINavigationController
    }

    private func setupAppearance() {
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.barTintColor = UIColor(named: "tabBarBarTintColor")
        tabBarAppearance.isTranslucent = false
        tabBarAppearance.tintColor = UIColor(named: "tabBarIconColorSelected")
    }

    func createTabs() {
        tabBar.isHidden = false

        let homeNavigationController = createNavigationController(MoviesViewController(loaderMovies: UpcomingMoviesLoader()),
                                                                  title: "Upcoming",
                                                                  icon: "movies")

        let searchNavigationController = createNavigationController(SearchViewController(),
                                                                    title: "Search",
                                                                    icon: "search")

        let profileNavigationController = createNavigationController(ProfileViewController(),
                                                                     title: "Profile",
                                                                     icon: "profile")

        setViewControllers([homeNavigationController,
                            searchNavigationController,
                            profileNavigationController],
                           animated: false)
    }

    private func createNavigationController(_ viewController: UIViewController, title: String, icon: String)
        -> UINavigationController {

        let icon = UIImage(named: icon)

        viewController.title = title
        viewController.tabBarItem.selectedImage = icon
        viewController.tabBarItem.image = icon
        viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)

        let navigationController = UINavigationController(rootViewController: viewController)

        return navigationController
    }
}

