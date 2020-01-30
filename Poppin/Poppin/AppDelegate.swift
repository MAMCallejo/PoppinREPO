//
//  AppDelegate.swift
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 10/13/19.
//  Copyright © 2019 PoppinREPO. All rights reserved.
//

import UIKit
import CoreData
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var dataController: DataController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        configureInitialRootViewController(for: window)
        
        dataController = DataController()
        
        dataController.initalizeStack()
        
        return true
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        
    }

}
extension AppDelegate {
    
    func configureInitialRootViewController(for window: UIWindow?) {
        
        let defaults = UserDefaults.standard
        
        let initialViewController: UIViewController

        if let _ = Auth.auth().currentUser,
            
           let userData = defaults.object(forKey: Constants.UserDefaults.currentUser) as? Data,
            
           let user = try? JSONDecoder().decode(User.self, from: userData) {
            
            User.setCurrent(user)
            
            initialViewController = UIStoryboard.initialViewController(for: .main)
            
        } else {
            
            initialViewController = UIStoryboard.initialViewController(for: .login)
            
        }

        window?.rootViewController = initialViewController
        
        window?.makeKeyAndVisible()
        
    }
    
}

