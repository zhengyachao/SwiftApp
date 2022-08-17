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
        print("isLogin----",isLogin)
        
        self.window = UIWindow.init()
        self.window?.backgroundColor = .white
        self.window?.frame = UIScreen.main.bounds
        self.window?.makeKeyAndVisible()
        
        let loginNavVC = YCNavigationController.init(rootViewController: LoginPageViewController())
        self.window?.rootViewController = isLogin ? YCTabbarViewController() : loginNavVC
        
        // Mark -- IQKeyboardManager键盘管理
        IQKeyboardManager.shared.enable = true

        // MARK -- 添加通知方法
        kNotificationCenter.addObserver(self, selector: #selector(onLoginSuccessNotify), name: NSNotification.Name(kLoginSuccessNotice), object: nil)
        kNotificationCenter.addObserver(self, selector: #selector(onLogoutSuccessNotify), name: NSNotification.Name(kLogoutSuccessNotice), object: nil)
        
        return true
    }
    
    @objc func onLoginSuccessNotify () {
        
        kUserDefaults.set(true, forKey: kIsLogin)
        kUserDefaults.synchronize()
        
        /// 跳转到Tabbar页
        kAppDelegate.window?.rootViewController = YCTabbarViewController()
    }
    
    @objc func onLogoutSuccessNotify () {
        
        kUserDefaults.set(false, forKey: kIsLogin)
        kUserDefaults.synchronize()
        
        /// 跳转到登录页
        let loginNavVC = YCNavigationController.init(rootViewController: LoginPageViewController())
        kAppDelegate.window?.rootViewController = loginNavVC
    }
    
}

