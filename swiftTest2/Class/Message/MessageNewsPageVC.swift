//
//  MessageNewsPageVC.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/29.
//

import UIKit
import JXSegmentedView
import SwiftyJSON
import HandyJSON

class MessageNewsPageVC: YCBaseViewController {

    //MARK: -- 存放typeId的数组
    lazy var typeIdArray = Array<Any>()
    
    //MARK: -- 标题下面的横线
    lazy var sliderView: JXSegmentedIndicatorLineView = {
        let sliderView = JXSegmentedIndicatorLineView()
        return sliderView
    }()
    
    //MARK: -- 标题数据源
    lazy var dataTitleSource: JXSegmentedTitleDataSource = {
        let dataTitleSource = JXSegmentedTitleDataSource()
        dataTitleSource.titleNormalColor = UIColor.smallFontColor
        dataTitleSource.titleSelectedColor = UIColor.mainFontColor
        return dataTitleSource
    }()
    
    //MARK: -- 容器视图
    lazy var listContainerView: JXSegmentedListContainerView = {
        let listContainerView = JXSegmentedListContainerView.init(dataSource: self, type: .scrollView)
        return listContainerView
    }()
    
    //MARK: -- 标题控件
    lazy var segmentView: JXSegmentedView = {
        let segmentView = JXSegmentedView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 50))
        segmentView.delegate = self
        segmentView.backgroundColor = UIColor.white
        segmentView.listContainer = listContainerView // 视图容器
        segmentView.indicators = [sliderView] // 标题下的横线
        segmentView.defaultSelectedIndex = 0
        return segmentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(self.segmentView)
        view.addSubview(self.listContainerView)
        // 获取所有新闻类型列表
        requestNewsType()
    }
    
    
    //MARK: -- 获取所有新闻类型列表
    func requestNewsType () {
        messageProvider.request(MessagePageApi.getNewsTypes) { result in
            switch result {
            case let .success(response):
                
                let jsonStr = JSON(response.data).description
                print("JSON字符串---",jsonStr)
                
                let nTypesModel = NewsTypesModel.deserialize(from: jsonStr)
                
                for item in nTypesModel?.data ?? [typeModel]() {
                    
                    self.dataTitleSource.titles.append(item.typeName)
                    
                    self.typeIdArray.append(item.typeId)
                }
                
                print("当前线程---",Thread.current)
                
                self.segmentView.dataSource = self.dataTitleSource
                self.segmentView.reloadData()
                
            case let .failure(error as NSError):
                print(error)
            }
        }
    }

}

//MARK: -- JXSegmentedListContainerViewDataSource
extension MessageNewsPageVC : JXSegmentedListContainerViewDataSource {

    //返回列表的数量
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        
        return self.dataTitleSource.titles.count
    }
    
    /*
     返回遵从`JXSegmentedListContainerViewListDelegate`协议的实例
     根据index初始化一个对应列表实例，需要是遵从`JXSegmentedListContainerViewListDelegate`协议的对象。
     如果列表是用自定义UIView封装的，就让自定义UIView遵从`JXSegmentedListContainerViewListDelegate`协议，该方法返回自定义UIView即可。
     如果列表是用自定义UIViewController封装的，就让自定义UIViewController遵从`JXSegmentedListContainerViewListDelegate`协议，该方法返回自定义UIViewController即可。
     注意：一定要是新生成的实例！！！
     */
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        
        let listVC = MessageNewsListVC()
        listVC.typeId = self.typeIdArray[index] as! String
        
        return listVC
    }
}

//MARK: -- JXSegmentedViewDelegate
extension MessageNewsPageVC : JXSegmentedViewDelegate {
    //点击选中的情况才会调用该方法
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        //传递didClickSelectedItemAt事件给listContainerView，必须调用！！！
        listContainerView.didClickSelectedItem(at: index)
        
        print("index----",index)
    }
}


