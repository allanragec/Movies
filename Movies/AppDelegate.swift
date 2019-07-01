//
//  AppDelegate.swift
//  Movies
//
//  Created by Allan Melo on 13/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MVTabBarController.shared
        window?.makeKeyAndVisible()

        updateGenres()

        return true
    }

    private func updateGenres() {
        let backgroundThread = ConcurrentDispatchQueueScheduler(qos: .background)

        let _ = GetGenresInteractor()
            .execute()
            .subscribeOn(backgroundThread)
            .subscribe()
    }
}

