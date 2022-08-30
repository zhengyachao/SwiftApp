//
//  NewsDetailModel.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/30.
//

import UIKit

class NewsDetailModel: YCBaseModel {

    var code: Int = 0
    var msg: String = ""
    var data: NewsDetailDataModel?
    
    required init() {
        
    }
}

class NewsDetailDataModel: YCBaseModel {
    var title: String = ""
    var content: String = ""
    var images: [NewsDetailDataImageModel]?
    var docid: String = ""
    var cover: String = ""
    var ptime: String = ""
    var source: String = ""
    
    required init() {
        
    }
}

class NewsDetailDataImageModel: YCBaseModel {

    var imgSrc: String = ""
    var position: String = ""
    var size: String = ""
    
    required init() {
        
    }
}
