//
//  FoodTypeListModel.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/9/5.
//

import UIKit
import HandyJSON

class FoodTypeListModel: YCBaseModel {

    var code : Int = 0
    var msg  : String = ""
    var data : [TypeListModel]?
    
    required init() {
        
    }
}

class TypeListModel: YCBaseModel {
    
    var id  : Int = 0
    var name  : String = ""
    var icon  : String = ""
    var isSelected: Bool = false
    
    required init() {
        
    }
    
    func mapping(mapper: HelpingMapper) {
        // 指定 typeId 字段用 "id" 去解析
        mapper.specify(property: &id, name: "typeId")
    }
}

