//
//  AppDelegate.swift
//  SmartNotepad
//
//  Created by Hadeer Kamel on 6/18/21.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // Keyboard
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true

        AppDelegate.setRootViewController()
        return true
    }

    static func setRootViewController(){
        DispatchQueue.main.async {
            self.window = UIWindow(frame:UIScreen.main.bounds)
            self.window?.rootViewController = UINavigationController(rootViewController:  NotesVC())
            self.window?.makeKeyAndVisible()
        }
    }
}

