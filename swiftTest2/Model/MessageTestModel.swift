//
//  MessageTestModel.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/29.
//

import UIKit

class MessageTestModel: YCBaseModel {

    var code : Int = 0
    var msg  : String = ""
    var data : [Daily_wordModel]?
    
    required init() {
        
    }
}

class Daily_wordModel: YCBaseModel {
    
    var author : String = ""
    var content : String = ""
    
    required init() {
        
    }
}
