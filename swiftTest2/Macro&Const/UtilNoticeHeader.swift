//
//  UtilNoticeHeader.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/17.
//

import Foundation
/*
 可以注意到，Swift中通知中心NotificationCenter不带NS前缀，
 通知名由字符串变成了NSNotification.Name的结构体。
 */
//Mark ---- 通知名称统一处理
extension NSNotification.Name {
    static let kLoginSuccessNotice  = NSNotification.Name("kLoginSuccessNotice")    // 登录成功通知
    static let kLogoutSuccessNotice = NSNotification.Name("kLogoutSuccessNotice")   // 登录成功通知

    
    static let kRefreshMessageListNotice = NSNotification.Name("kRefreshMessageListNotice")   //刷新Message列表成功通知

}

