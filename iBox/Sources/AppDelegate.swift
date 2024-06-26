//
//  AppDelegate.swift
//  iBox
//
//  Created by 김찬희 on 2023/12/21.
//

import CoreData
import UIKit
import WebKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let versioningHandler: VersioningHandler = VersioningHandler()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        workaroundInitialWebViewDelay()

        versioningHandler.checkAppVersion { result in
            AppStateManager.shared.versionCheckCompleted = result
        }
        
        return true
    }
    
    func workaroundInitialWebViewDelay() {
        let webView = WKWebView()
        webView.loadHTMLString("", baseURL: nil)
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

