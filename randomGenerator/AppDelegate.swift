//
//  AppDelegate.swift
//  randomGenerator
//
//  Created by R C on 10/28/20.
//

import UIKit
import GoogleMobileAds
//import AppTrackingTransparency
//import AdSupport
//import KeychainSwift




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        let settings = SettingsViewController()
//        let main = DashboardViewController()
//        let noAds = settings.keychain.get("purchased")
//        print(settings.keychain.allKeys)
//        if global.noAds == true {
//            main.googleAdBanner.isHidden = true
//        } else {
//            main.setUpBanner()
//        }
        
//        print(noAds)
    
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ kGADSimulatorID ]

        GADMobileAds.sharedInstance().start(completionHandler: nil)
//        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ "1e4cb67b7b0c4a90e668f838669fd162" ]
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ "e332aff4d23f3741f3d0130d5b0687cc" ]
//            main.setUpBanner()
//        }
        return true
    }
//    func requestIDFA() {
//      ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
//
//        // Tracking authorization completed. Start loading ads here.
//        // loadAd()
//      })
//    }
    

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

