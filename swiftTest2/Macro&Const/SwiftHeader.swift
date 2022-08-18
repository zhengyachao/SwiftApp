//
//  SwiftHeader.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/17.
//

import Foundation

//MARK: 纯代码布局--类似OC的Masonry
import SnapKit
import SnapKitExtend

//MRAK: 应用通用配置
let kScreenWidth  = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height
let keyWindow     = UIApplication.shared.delegate!.window
let kUserDefaults = UserDefaults.standard
let kNotificationCenter = NotificationCenter.default
let kAppDelegate  = UIApplication.shared.delegate as! AppDelegate


//MRAK:是否是刘海屏
var kDevice_Is_iPhoneX : Bool {
    guard #available(iOS 11.0, *) else {
        return false
    }
    // 安全区域
    let isX = UIApplication.shared.windows[0].safeAreaInsets.bottom > 0
    
    return isX
}

let kStatusBarHeight = kDevice_Is_iPhoneX ? 44.0 : 20.0   // 状态栏高度
let kAppNavBarHeight = kDevice_Is_iPhoneX ? 88.0 : 64.0   // 导航栏高度
let kAppTabBarHeight = kDevice_Is_iPhoneX ? 83.0 : 49.0   // tabBar高度
let kAppNavAndTabBarHeight = kAppNavBarHeight + kAppTabBarHeight   // 导航栏高度 + tabBar高度


//MRAK: 应用默认颜色
extension UIColor {
    // 页面背景颜色
    class var background: UIColor {
        
        return UIColor.hex(hexString: "#F2F2F2")
    }
    // app主题颜色
    class var theme: UIColor {
        
        return UIColor.hex(hexString: "#1785AA")
    }
    // 主字体颜色--黑色
    class var mainFontColor: UIColor {
        
        return UIColor.hex(hexString: "#333333")
    }
    // 次字体颜色--灰色
    class var subFontColor: UIColor {
        
        return UIColor.hex(hexString: "#666666")
    }
    // 再次字体颜色--浅灰色
    class var smallFontColor: UIColor {
        
        return UIColor.hex(hexString: "#999999")
    }
}


