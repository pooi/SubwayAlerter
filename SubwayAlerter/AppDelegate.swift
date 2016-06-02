//
//  AppDelegate.swift
//  SubwayAlerter
//
//  Created by 유태우 on 2016. 5. 5..
//  Copyright © 2016년 유태우. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // 로컬알림 설정 부분
        // Actions
        let firstAction:UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        firstAction.identifier = "FIRST_ACTION"
        firstAction.title = "첫번째 시간표"
        
        firstAction.activationMode = UIUserNotificationActivationMode.Background
        firstAction.destructive = true
        firstAction.authenticationRequired = false
        
        let secondAction:UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        secondAction.identifier = "SECOND_ACTION"
        secondAction.title = "두번째 시간표"
        
        secondAction.activationMode = UIUserNotificationActivationMode.Background
        secondAction.destructive = false
        secondAction.authenticationRequired = false
        
        let thirdAction:UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        thirdAction.identifier = "THIRD_ACTION"
        thirdAction.title = "기타"
        
        thirdAction.activationMode = UIUserNotificationActivationMode.Foreground
        thirdAction.destructive = false
        thirdAction.authenticationRequired = false
        
        // category
        
        let firstCategory:UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
        firstCategory.identifier = "FIRST_CATEGORY"
        
        let defaultActions:NSArray = [firstAction, secondAction, thirdAction]
        let minimalActions:NSArray = [secondAction, firstAction]
        
        firstCategory.setActions(defaultActions as? [UIUserNotificationAction], forContext: UIUserNotificationActionContext.Default)
        firstCategory.setActions(minimalActions as? [UIUserNotificationAction], forContext: UIUserNotificationActionContext.Minimal)
        
        //NSSet of all our categories
        
        let categories:NSSet = NSSet(objects: firstCategory)
        
        
        
        
        let types:UIUserNotificationType = UIUserNotificationType.Alert.union(UIUserNotificationType.Badge).union(UIUserNotificationType.Sound)
        
        let mySettings:UIUserNotificationSettings = UIUserNotificationSettings(forTypes: types, categories: categories as? Set<UIUserNotificationCategory>)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(mySettings)
        
        //=============
        
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

