//
//  AppDelegate.swift
//  Workout
//
//  Created by Рустам Амирханов on 01.04.2020.
//  Copyright © 2020 IDOLE. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import YandexMobileMetrica
import FirebaseCoreDiagnostics
import YandexMobileMetricaCrashes

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let notificationCenter = UNUserNotificationCenter.current()
    lazy var coreDataStack = CoreDataStack()
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupTabbar()
        setupAnalytics()
        setupNotification()
        
        return true
    }
    
    //MARK:- Настройка уведомлений
        
        func setupNotification() {
            notificationCenter.delegate = self
            let options: UNAuthorizationOptions = [.alert, .sound, .badge]
            
            notificationCenter.requestAuthorization(options: options) {
                (didAllow, error) in
                if !didAllow {
                    print("User has declined notifications")
                }
            }
        }
        
        func scheduleNotification(notificationType: String) {
            
            let content = UNMutableNotificationContent() // Содержимое уведомления
            
            content.title = "Возвращайся скорее"
            content.body = "Каждая тренировка имеет значение 🎉"
            content.sound = UNNotificationSound.default
            content.badge = 1
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1200, repeats: false)
            let identifier = "Local Notification"
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            
            notificationCenter.add(request) { (error) in
                if let error = error {
                    print("Error \(error.localizedDescription)")
                }
            }
        }
        
        func applicationDidBecomeActive(_ application: UIApplication) {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    
    //MARK:- Аналитика
    
    func setupAnalytics() {
        setupYandex()
        setupFirebase()
    }
    
    func setupFirebase() {
        FirebaseApp.configure()
    }
    
    func setupYandex() {
        let configuration = YMMYandexMetricaConfiguration.init(apiKey: "5a0ef0d5-8775-46dd-a62a-7b7da6df847a")
        YMMYandexMetrica.activate(with: configuration!)
    }
    
    //MARK:- TabBar
    
    func setupTabbar() {
        UITabBar.appearance().layer.borderWidth = 0.0
        UITabBar.appearance().clipsToBounds = true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
    //MARK:- Настройка CoreData
    
    func applicationWillTerminate(_ application: UIApplication) {
        
      self.coreDataStack.saveContext()
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
           
           if response.notification.request.identifier == "Local Notification" {
            
           }
           
           completionHandler()
       }
}
