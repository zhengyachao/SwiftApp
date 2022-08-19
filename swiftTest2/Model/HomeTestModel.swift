//
//  HomeTestModel.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/18.
//

import UIKit

class HomeTestModel: YCBaseModel {

    var rescode : String = ""
    var resMessage : String = ""
    var data: ForecastModel?
    
    required init() {
        
    }
    
    /*
     字段自定义如何处理 (当model的属性名和json里的对应不上，model里实现
     mapping函数去对应key就可以了)
     重写 mapping 方法
     
     func mapping(mapper: HelpingMapper) {
         mapper <<< self.name <-- "name_id" //语法直接复制
     }
     */
}

class ForecastModel : YCBaseModel {
   
    var relationMajorType : Int = 0
  
    required init() {
        
    }
}
