//
//  AppDelegate.swift
//  Defining and Processing iBeacons - Source
//
//  Created by Vandad Nahavandipoor on 7/8/14.
//  Copyright (c) 2014 Pixolity Ltd. All rights reserved.
//
//  These example codes are written for O'Reilly's iOS 8 Swift Programming Cookbook
//  If you use these solutions in your apps, you can give attribution to
//  Vandad Nahavandipoor for his work. Feel free to visit my blog
//  at http://vandadnp.wordpress.com for daily tips and tricks in Swift
//  and Objective-C and various other programming languages.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let defaults = NSUserDefaults.standardUserDefaults()
        if let launchview = defaults.stringForKey("LaunchView")
        {
            if launchview == "FirstViewController" {
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.window = UIWindow(frame: UIScreen.mainScreen().bounds)
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let yourVC = mainStoryboard.instantiateViewControllerWithIdentifier("VC1") as! FirstViewController
                appDelegate.window?.rootViewController = yourVC
                appDelegate.window?.makeKeyAndVisible()
            }
            else if launchview == "SecondViewController" {
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.window = UIWindow(frame: UIScreen.mainScreen().bounds)
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let yourVC = mainStoryboard.instantiateViewControllerWithIdentifier("VC2") as! SecondViewController
                appDelegate.window?.rootViewController = yourVC
                appDelegate.window?.makeKeyAndVisible()
            }
        }
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}