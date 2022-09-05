//
//  FoodListModel.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/9/5.
//

import UIKit

class FoodListModel: YCBaseModel {

    var code : Int = 0
    var msg  : String = ""
    var data : FoodDataModel?
    
    required init() {
        
    }
}

class FoodDataModel: YCBaseModel {
    
    var page : Int = 0
    var totalCount : Int = 0
    var totalPage : Int = 0
    var limit : Int = 0
    var list : [FoodDataListModel]?
    
    required init() {
            
    }
}

class FoodDataListModel: YCBaseModel {
    
    var foodId : String = ""
    var name : String = ""
    var healthLevel : Int = 0
    var calory : String = ""
    
    required init() {
        
    }
}
