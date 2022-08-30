//
//  NewsListModel.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/30.
//

import UIKit

class NewsListModel: YCBaseModel {
    
    var code : Int = 0
    var msg  : String = ""
    var data : [NewsListDataModel]?
    
    required init() {
        
    }
}


class NewsListDataModel: YCBaseModel {

    var newsId : String = ""
    var title  : String = ""
    var source  : String = ""
    var videoList  : [String]?
    var imgList  : [String]?
    var postTime : String = ""
    var digest  : String = ""
    required init() {
        
    }
}

