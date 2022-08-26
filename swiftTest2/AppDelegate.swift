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
        
        //保存打印日志到沙盒
//        redirectNSlogToDocumentFolder()
        
        let uuid = YCDeviceManager.shared.getDeviceUUIDAndSaveUUIDToKeyChain()
        
        print("uuid------",uuid)
        
        return true
    }
    
    //MARK: 保存打印日志到沙盒--重定向NSLog日志重定向到指定的文件目录中。
    private func redirectNSlogToDocumentFolder() {
        let filePath: String  =  NSHomeDirectory () +  "/Documents/PrintfInfo.log"
        let defaultManager = FileManager.default
        try? defaultManager.removeItem(atPath: filePath)
        /*
         freopen是被包含于C标准库头文件<stdio.h>中的一个函数，用于重定向输入输出流。
         该函数可以在不改变代码原貌的情况下改变输入输出环境，但使用时应当保证流是可靠的。
         filename:需要重定向到的文件名或文件路径。
         mode:代表文件访问权限的字符串。例如，"r"表示"只读访问"、"w"表示"只写访问"、"a"表示"追加写入"。
         stream:需要被重定向的文件流。
         */
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


