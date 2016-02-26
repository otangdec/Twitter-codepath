//
//  AppDelegate.swift
//  Twitter
//

//

import UIKit
import BDBOAuth1Manager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyboard = UIStoryboard(name: "Main", bundle: nil)

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        // Override point for customization after application launch.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogout", name: userDidLogoutNotification, object: nil)
        
        if let _  = User.currentUser {
            // Go to the logged in screen
            let vc = storyboard.instantiateViewControllerWithIdentifier("TwitterNavigationController")             
            
            window?.rootViewController = vc
        }
    
        
        initializeTabBar()
        return true
    }

    func userDidLogout() {
        let vc = storyboard.instantiateInitialViewController()! as UIViewController
        window?.rootViewController = vc
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
    
    @available(iOS, deprecated=8.0)
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {

        TwitterClient.sharedInstance.openURL(url)
                return true
    }
    
    func initializeTabBar() {
        //first tab item
        let tweetsViewController = storyboard.instantiateViewControllerWithIdentifier("TwitterNavigationController") as! UINavigationController
        tweetsViewController.tabBarItem.title = "Timeline"
        tweetsViewController.tabBarItem.image = UIImage(named: "home")

        //second tab item
        let notificationViewController = storyboard.instantiateViewControllerWithIdentifier("NotificationViewController")
        notificationViewController.tabBarItem.title = "Notification"
        notificationViewController.tabBarItem.image = UIImage(named: "notification")
        
        //third tab item
        let messageViewController = storyboard.instantiateViewControllerWithIdentifier("MessageViewController")
        messageViewController.tabBarItem.title = "Message"
        messageViewController.tabBarItem.image = UIImage(named: "message")
        
        //fourth tab item
        let profileViewController = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController")
        profileViewController.tabBarItem.title = "Profile"
        profileViewController.tabBarItem.image = UIImage(named: "profile")


        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [tweetsViewController, notificationViewController, messageViewController, profileViewController]
        tabBarController.tabBar.tintColor = UIColor(red: 70/255, green: 181/255, blue: 251/255, alpha: 1)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

}

