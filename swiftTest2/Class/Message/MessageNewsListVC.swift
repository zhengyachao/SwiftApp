//
//  MessageNewsListVC.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/29.
//

import UIKit
import JXSegmentedView
import SwiftyJSON
import HandyJSON

class MessageNewsListVC: YCBaseViewController {
    var page = 1
    var typeId = String()
    
    lazy var dataArray = Array<Any>()
    lazy var dataDict = Dictionary<String,String>()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 获取新闻列表Api
        requestNewsListApi()
    }
    
    //MARK: -- 根据新闻类型获取新闻列表Api
    func requestNewsListApi() {
        print("typeId------",self.typeId)
        messageProvider.request(MessagePageApi.getNewsList(typeId: self.typeId, page: self.page)) { result in
            switch result {
            case let .success(response):
                
                let jsonStr = JSON(response.data).description
                print("JSON字符串---",jsonStr)
            case let .failure(error as NSError):
                print(error)
            }
        }
    }
}

extension MessageNewsListVC : JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        
        return self.view
    }
}
