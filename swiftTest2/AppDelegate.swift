//
//  AppDelegate.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/16.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 是否登录
        let isLogin = kUserDefaults.bool(forKey: kIsLogin)
        print("111111----",isLogin)
        
        self.window = UIWindow.init()
        self.window?.backgroundColor = .white
        self.window?.frame = UIScreen.main.bounds
        self.window?.makeKeyAndVisible()
        
        let loginNavVC = YCNavigationController.init(rootViewController: LoginPageViewController())
        self.window?.rootViewController = isLogin ? YCTabbarViewController() : loginNavVC
        
        // Mark -- IQKeyboardManager键盘管理
        IQKeyboardManager.shared.enable = true

        
        return true
    }
    
}

