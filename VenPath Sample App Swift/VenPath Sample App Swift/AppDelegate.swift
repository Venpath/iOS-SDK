//
//  AppDelegate.swift
//  VenPath Sample App Swift
//
//  Copyright © 2017 VenPath. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var venpath: VenPath!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.venpath = VenPath.shared()
        self.venpath.sdkKey("SDK KEY HERE", publicKey: "TOKEN HERE", secretKey: "SECRET HERE")

//        venpath.debug = true;
//        sendEmailToVenPath(email: "newtest@newemail.com")
//        sendAppUsageToVenPath()
        
        return true
    }

    func sendEmailToVenPath( email:String ) {
        self.venpath.track(["email":email, "newUser":"true"])
    }
    
    func sendAppUsageToVenPath() {
        let timestamp = Int(Int64(Date().timeIntervalSince1970))
        self.venpath.track(
                ["app_name":"Test App",
                "event_date":timestamp,
                "event_type": "launch",
                "seconds_used": "100",
                "permissions":"comma,delimited,list"]
        )
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

public var venpath:VenPath{
    get{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.venpath
    }
}

