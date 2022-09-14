//
//  MessageDataViewController.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/9/2.
//

import UIKit

class MessageDataViewController: YCBaseViewController {
    
    /*
     初始化数组
     */
    var temArray1 = Array<Any>()
    var temArray2 = [Any?]()
    /*
     初始化集合
     */
    var set = Set<String>()
    
    /*
     初始化字典
     一个字典的 Key 类型必须遵循 Hashable 协议，就像 Set 的值类型。
     Dictionary<Key, Value>
     */
    var dict1 = Dictionary<String, Any>()
    var dict2 = [String:String]()
    var dict3 = [1:"1"]

    override func viewDidLoad() {
        super.viewDidLoad()

        let str1 = 1
        let str2 = String(str1)
        let str3 =
"""
1111
2222
3333
"""
        print("str2----\(str2)")
        
        print("str3 ----\(str3)")
        // Do any additional setup after loading the view.
        temArray1.append(1)
        temArray1.append("one")
        temArray1.append(["dict":"333"])
        print("temArray1----\(temArray1)")
        
        for item in temArray1 {
            
            print("item----\(item)")
        }
        
        print("dict3----1\(dict3)")
        dict3 = [:]
        print("dict3----2\(dict3)")
    }
}
