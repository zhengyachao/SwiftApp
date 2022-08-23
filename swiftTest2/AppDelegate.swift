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
    
    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 是否登录
        let isLogin = kUserDefaults.bool(forKey: kIsLogin)
        print("isLogin----",isLogin)
        
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        let loginNavVC = YCNavigationController.init(rootViewController: LoginPageViewController())
        window?.rootViewController = isLogin ? YCTabbarViewController() : loginNavVC
        
        // Mark -- IQKeyboardManager键盘管理
        IQKeyboardManager.shared.enable = true

        // MARK -- 添加通知方法
        kNotificationCenter.addObserver(self, selector: #selector(onLoginSuccessNotify(_:)), name: NSNotification.Name(kLoginSuccessNotice), object: nil)
        kNotificationCenter.addObserver(self, selector: #selector(onLogoutSuccessNotify), name: NSNotification.Name(kLogoutSuccessNotice), object: nil)
        
        //崩溃日志
        self.redirectNSlogToDocumentFolder()
        
        return true
    }
    //MARK: 保存打印日志到沙盒
    private func redirectNSlogToDocumentFolder() {
        let filePath: String  =  NSHomeDirectory () +  "/Documents/PrintfInfo.log"
        let defaultManager = FileManager.default
        try? defaultManager.removeItem(atPath: filePath)
        
        freopen(filePath.cString(using: String.Encoding.ascii), "a+", stdout)
        freopen(filePath.cString(using: String.Encoding.ascii), "a+", stderr)
    }
    
    //MARK: 登录成功通知
    @objc func onLoginSuccessNotify (_ notify : NSNotification) {
        
        kUserDefaults.set(true, forKey: kIsLogin)
        kUserDefaults.synchronize()
        
        /// 跳转到Tabbar页
        kAppDelegate.window?.rootViewController = YCTabbarViewController()
    }
    //MARK: 退出登录通知
    @objc func onLogoutSuccessNotify () {
        
        kUserDefaults.set(false, forKey: kIsLogin)
        kUserDefaults.synchronize()
        
        /// 跳转到登录页
        let loginNavVC = YCNavigationController.init(rootViewController: LoginPageViewController())
        kAppDelegate.window?.rootViewController = loginNavVC
    }
}


