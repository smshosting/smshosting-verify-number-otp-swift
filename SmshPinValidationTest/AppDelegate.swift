//
//  AppDelegate.swift
//  SmshPinValidationTest
//
//  Created by Sviluppo 3 on 26/05/17.
//  Copyright © 2017 i-contact. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //SmsHostingVerify Initial Configuration
        SmshostingVerify.startWithKeyAndSecret(key:"SMSHZ9J9TXJ8MD7DZ33G3", secret:"K51RGU8PKJQT2P0BCLVGR4SJLF3ACHMB")
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let controller:TestViewController = TestViewController()
        let nav:UINavigationController = UINavigationController(rootViewController: controller)
        
        window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

