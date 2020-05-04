//
//  AppDelegate.swift
//  Workout
//
//  Created by Рустам Амирханов on 01.04.2020.
//  Copyright © 2020 IDOLE. All rights reserved.
//

import UIKit
import Firebase
import YandexMobileMetrica
import FirebaseCoreDiagnostics
import YandexMobileMetricaCrashes

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    lazy var coreDataStack = CoreDataStack()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupTabbar()
        setupAnalytics()
        
        return true
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

