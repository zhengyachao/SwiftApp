//
//  NewsTypesModel.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/29.
//

import UIKit

class NewsTypesModel: YCBaseModel {

    var code : Int = 0
    var data : [typeModel]?
    
    required init() {
        
    }
}

class typeModel : YCBaseModel {
    var typeId : String = ""
    var typeName : String = ""
    
    required init() {
        
    }
}

