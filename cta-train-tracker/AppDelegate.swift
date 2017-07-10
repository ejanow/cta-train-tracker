//
//  AppDelegate.swift
//  cta-train-tracker
//
//  Created by e on 4/27/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Utils.initializeApp()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        backgroundArrivalRefreshingSet(false, for: application)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        backgroundArrivalRefreshingSet(false, for: application)
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        backgroundArrivalRefreshingSet(true, for: application) // This worries me a bit. I don't want two refresh threads active...
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        backgroundArrivalRefreshingSet(false, for: application)
    }
    
    private func backgroundArrivalRefreshingSet(_ b: Bool, for application: UIApplication) {
        
        if let window: UIWindow = application.keyWindow {
            
            if let arrController = window.rootViewController as? ArrivalsTableViewController {
                
                arrController.refreshing = b
                if b { arrController.refreshArrivals() }
            }
        }
    }
}

