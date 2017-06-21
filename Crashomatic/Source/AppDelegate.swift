//
//  AppDelegate.swift
//  Crashomatic
//
//  Created by Jereme Claussen on 6/20/17.
//  Copyright © 2017 Jereme Claussen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        NewRelic.start(withApplicationToken: "AA7db3c601e378dacc575ba7e207efdba923ea17bf")

        return true
    }

}

