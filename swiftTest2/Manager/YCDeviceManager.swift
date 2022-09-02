//
//  YCDeviceManager.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/26.
//

import UIKit


let  keychain_service = "com.trustmobi.demo.swiftTest2"
let  keychain_account = "swiftTest2KeyChain_Account"

class YCDeviceManager: NSObject {
    static let shared = YCDeviceManager()

    private override init() {}

    override func copy() -> Any {
        return self
    }

    override func mutableCopy() -> Any {
        return self
    }
    
    //MARK: -- 获取设备的UUID并保存到钥匙串
    func getDeviceUUIDAndSaveUUIDToKeyChain () -> String {
        
        var uuid = SSKeychain.password(forService: keychain_service, account: keychain_account )
        var error: NSError? = nil
        // ?? 空合运算符 uuid?.isEmpty ?? true表示判断uuid?.isEmpty是否为nil，若为nil，取true的值
        if uuid?.isEmpty ?? true {
            // 获取UUID
//            uuid = UIDevice.current.identifierForVendor!.uuidString
            uuid = String.lh_UUIDString()
            print("uuid---\(uuid ?? "")")
            SSKeychain.setPassword(uuid, forService: keychain_service, account: keychain_account, error: &error)
        }
        
        return uuid!
    }
}
