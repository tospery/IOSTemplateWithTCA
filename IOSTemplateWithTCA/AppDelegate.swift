//
//  AppDelegate.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2024/10/15.
//

import UIKit
import HiLog

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(
        _ application: UIApplication, 
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        log("【AppDelegate】didFinishLaunchingWithOptions: \(application.connectedScenes)")
        if let scene = application.connectedScenes.first as? UIWindowScene {
            self.window = UIWindow(windowScene: scene)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.test(launchOptions: launchOptions)
        }
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        log("【AppDelegate】applicationDidBecomeActive")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        log("【AppDelegate】applicationWillEnterForeground")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        log("【AppDelegate】applicationDidEnterBackground")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        log("【AppDelegate】applicationWillTerminate")
    }

    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        log("【AppDelegate】application - open url")
        return true
    }
    
    // MARK: - userActivity
    func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        log("【AppDelegate】application - continue userActivity")
        return true
    }
    
    func test(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
    }
    
}
