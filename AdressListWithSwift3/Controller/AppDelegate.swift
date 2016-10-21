//
//  AppDelegate.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/12.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

let application = UIApplication.shared
let appDelegate = application.delegate as! AppDelegate
let tabBarController = appDelegate.tabBarController
let tabBar = tabBarController.tabBar


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate ,UITabBarControllerDelegate{

    var window: UIWindow?
    var tabBarController = YTTabBarController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.initWindow()
        self.initPush()
        
//        self.registerNotification(alerTime: 3)
        
        self.loadLoginVC()
        
        return true
    }
    func initWindow()
    {
        tabBarController.delegate = self
        self.window = UIWindow(frame: kScreenBounds)
        self.window?.rootViewController = tabBarController
        self.window?.backgroundColor = WhiteColor
        self.window?.makeKeyAndVisible()
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:YES]; 
    }
    
    func loadLoginVC()
    {
        //若没有登录，则加载登录界面
        if !dataCenter.isAlreadyLogin() {
            let navi = YTNavigationController(rootViewController: LoginController())
            navi.initNavigationBar()
            self.window?.rootViewController?.present(navi, animated: true, completion: nil)
        }
    }
    
    //注册推送
    func initPush()
    {
        if (kSystemVersionNum_Greater_Than_Or_Equal_To_10) {
            // 使用 UNUserNotificationCenter 来管理通知
            let center = UNUserNotificationCenter.current()
            //监听回调事件
            center.delegate = self;
            
            //iOS 10 使用以下方法注册，才能得到授权
            center.requestAuthorization(options: [UNAuthorizationOptions.alert,UNAuthorizationOptions.badge], completionHandler: { (granted:Bool, error:Error?) -> Void in
                if (granted) {
                    //点击允许
                    print("注册通知成功")
                    //获取当前的通知设置，UNNotificationSettings 是只读对象，不能直接修改，只能通过以下方法获取
                    center.getNotificationSettings(completionHandler: { (settings:UNNotificationSettings) in
                        print("2222222222")
                    })
                } else {
                    //点击不允许
                    print("注册通知失败")
                }
            })
            UIApplication.shared.registerForRemoteNotifications()
        
        }
    }
    //本地推送
    func registerNotification(alerTime:Int) {
    
        // 使用 UNUserNotificationCenter 来管理通知
        let center = UNUserNotificationCenter.current()
    
        //需创建一个包含待通知内容的 UNMutableNotificationContent 对象，注意不是 UNNotificationContent ,此对象为不可变对象。
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Hello!", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Hello_message_body", arguments: nil)
        content.sound = UNNotificationSound.default()
    
        // 在 alertTime 后推送本地推送
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(alerTime), repeats: false)
        let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger)
        //添加推送成功后的处理！
        center.add(request) { (error:Error?) in
            let alert = UIAlertController(title: "本地通知", message: "成功添加推送", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancel)
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - UNUserNotificationCenterDelegate
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //1. 处理通知
        
        //2. 处理完成后条用 completionHandler ，用于指示在前台显示通知的形式
        completionHandler(UNNotificationPresentationOptions.alert);
        
        print("3333333333")
    }
    
    
    
    //当推送注册成功时 系统会回调以下方法 会得到一个 deviceToken
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = String(data: deviceToken, encoding: .utf8)
        print("push_token = ",token)
        
    }
    //当推送注册失败时 系统会回调
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    //当有消息推送到设备 并且点击消息启动app 时会回调 userInfo 就是服务器推送到客户端的数据
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        
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
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.enjoytouch.CoreDataDemo" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "AdressListWithSwift3", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

    //MARK: -UITabBarControllerDelegate
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let navi = viewController as! YTNavigationController
        if navi.index >= 2 {//请假列表
            if !dataCenter.isAlreadyLogin() { //未登录
                self.loadLoginVC()
                return false
            }
        }
        return true
    }
    //切换tabBar到首页
    func setTabBarSelectViewController(index:Int)
    {
        tabBarController.selectedIndex = index
    }
}


