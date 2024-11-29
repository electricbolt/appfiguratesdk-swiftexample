// AppDelegate.swift
// SwiftExample Copyright© 2017; Electric Bolt Limited.

import UIKit
import AppfigurateLibrary

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
        
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return APLApplicationOpenURL(url)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        APLApplicationDidFinishLaunchingWithOptions(launchOptions)
        
#if DEBUG
        // Allows XCUITest automation test cases to invoke functionality and return results from the app under test.
        APLAutomationMessageReceivedBlock { message, plist in
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first!
            
            if (message == "SetDarkMode") {
                let bool = plist as! Bool
                window.overrideUserInterfaceStyle = bool ? .dark : .light
            } else if message == "GetDarkMode" {
                let bool = window.traitCollection.userInterfaceStyle == .dark
                return bool
            }
            return nil
        }
#endif
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
}

