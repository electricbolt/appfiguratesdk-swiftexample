// AppDelegate.swift
// SwiftExample Copyright© 2017-2026; Electric Bolt Limited.

import UIKit
import AppfigurateLibrary
import FirebaseCore
import FirebaseRemoteConfig

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication,
                      configurationForConnecting connectingSceneSession: UISceneSession,
                      options: UIScene.ConnectionOptions) -> UISceneConfiguration {
         return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
     }
}

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var remoteConfig: RemoteConfig!

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        // When your app opens a URL while running or suspended in memory.
        APLApplicationOpenURL(URLContexts.first?.url)
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // After launch.
        APLApplicationOpenURL(connectionOptions.urlContexts.first?.url)
        
#if DEBUG
        // Allows XCUITest automation test cases to invoke functionality and return results from the app under test.
        APLAutomationMessageReceivedBlock { message, plist in
            let window = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }!

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

        initFirebaseRemoteConfig();
    }
    
    func initFirebaseRemoteConfig() {
        FirebaseApp.configure()
        remoteConfig = RemoteConfig.remoteConfig()
        let remoteConfigSettings = RemoteConfigSettings()
        remoteConfigSettings.minimumFetchInterval = 0
        remoteConfig.configSettings = remoteConfigSettings

        // Set default values for firebase remote config to those from the reset() method of the ExampleConfiguration class.
        remoteConfig.setDefaults(APLConfiguration.shared().remoteDefaults())

        APLFetchRemoteConfiguration { propertyKey, propertyType, _ in
            if propertyType == .string {
                return self.remoteConfig.configValue(forKey: propertyKey).stringValue as NSObject
            } else if propertyType == .bool {
                return self.remoteConfig.configValue(forKey: propertyKey).boolValue as NSObject
            } else { // .int || .double
                return self.remoteConfig.configValue(forKey: propertyKey).numberValue as NSObject
            }
        }

        remoteConfig.fetch { status, error in
            if status == .success {
                self.remoteConfig.activate { changed, error in
                    print("Remote config updated keys")
                    APLFlushRemoteConfiguration()
                }
            }
        }
        remoteConfig.addOnConfigUpdateListener { configUpdate, error in
            if error == nil {
                self.remoteConfig.activate { changed, error in
                    print("Remote config updated keys")
                    APLFlushRemoteConfiguration()
                }
            }
        }
    }
}
