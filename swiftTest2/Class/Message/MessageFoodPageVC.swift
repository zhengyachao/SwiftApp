//
//  MessageFoodPageVC.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/9/5.
//

import UIKit
import SwiftyJSON
import HandyJSON

class MessageFoodPageVC: YCBaseViewController {
    var page : Int = 1
    var typeId: String = ""
    var typeName: String = ""
    lazy var leftListArray  = Array<Any>()
    lazy var rightListArray = Array<Any>()
    
    let group = DispatchGroup()
    /*
     label -> 队列名字
     qos -> 优先级
     attributes -> 属性列表，可以在这里设置同步异步（添加了 .concurrent 就是并发对列，否则就是穿行队列）
     autoreleaseFrequency -> block 内制动释放的频率
     target->想要 block 在哪个对列执行，默认是当前对列
     */
    let concurrentQueue = DispatchQueue(label: "testQueu", qos: .default, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
    
    //左侧表格
    lazy var leftTableView : UITableView = {
        let leftTableView = UITableView(frame: .zero, style: .grouped)
        leftTableView.delegate = self
        leftTableView.dataSource = self
        leftTableView.rowHeight = 55
        leftTableView.showsVerticalScrollIndicator = false
        leftTableView.backgroundColor = .background
        leftTableView.tableViewNeverAdjustContentInset()
        leftTableView.bounces = false
        return leftTableView
    }()
    
    //右侧表格
    lazy var rightTableView : UITableView = {
        let rightTableView = UITableView(frame: .zero, style: .grouped)
        rightTableView.delegate = self
        rightTableView.dataSource = self
        rightTableView.rowHeight = 80
        rightTableView.showsVerticalScrollIndicator = false
        rightTableView.tableViewNeverAdjustContentInset()
        return rightTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(self.leftTableView)
        view.addSubview(self.rightTableView)
        self.leftTableView.snp.makeConstraints { make in
            make.left.top.bottom.equalTo(view)
            make.width.equalTo(80)
        }
        
        self.rightTableView.snp.makeConstraints { make in
            make.left.equalTo(self.leftTableView.snp_right)
            make.right.top.bottom.equalTo(view)
        }
        
        // 创建队列数据1 --- 信号量(DispatchSemaphore) + notify
         createSequenceNetworking()
        // 创建队列数据2 --- group.enter()&&group.leave() + notify
         createGroupQueueNetworking()
        // 异步栅栏函数 + 自定义队列
        // createAsyncBarrierAndConcurrentQueue()
    }
    //MARK: -- 异步栅栏函数 + 自定义队列(这里回调有问题)
    func createAsyncBarrierAndConcurrentQueue () {
        
        concurrentQueue.sync { [weak self] in
            
            print("AAAAA----",Thread.current)
            self?.requestFoodHeatTypeList()
        }
        /*
         group -> 调度组
         qos   -> 优先级
         flags -> 附加属性，可以在这里设置为栅栏函数
         work  -> block
         */
        concurrentQueue.sync(flags: .barrier) {
            
            print("BBBBB----",Thread.current)
        }
        
        concurrentQueue.sync { [weak self] in
            
            print("CCCCC-----",Thread.current)
            self?.requestFoodHeatFoodList()
        }
    }
    
    //MARK: -- group.enter()&&group.leave() + notify
    func createGroupQueueNetworking() {
        let queue = DispatchQueue(label: "MessageFoodPageQueue2", qos: .default, attributes: .concurrent)
        
        queue.async(group: group, qos: .default) { [weak self] in
            self?.requestFoodHeatTypeList()
        }
        
        group.notify( queue: DispatchQueue.main) { [weak self] in
            self?.requestFoodHeatFoodList()
        }
    }
    
    //MARK: -- GCD 信号量(DispatchSemaphore)/group.enter()&&group.leave() + notify
    func createSequenceNetworking () {
        
        /*
         默认创建是串行队列
         label:队列的名称
         qos:优先级
         sync:同步
         attributes:此处设置为concurrent(并发队列)
         */
        let queue = DispatchQueue(label: "MessageFoodPageQueue1", qos: .default, attributes: .concurrent)
        
        queue.async(group: group, qos: .default) { [weak self] in
            self?.requestFoodHeatTypeList()
        }
        
        group.notify( queue: DispatchQueue.main) { [weak self] in
            self?.requestFoodHeatFoodList()
        }
        
    }
    //MARK: -- 获取食物的分类列表
    func requestFoodHeatTypeList () {
        
        let sema = DispatchSemaphore(value: 0)
        group.enter()
        messageProvider.request(MessagePageApi.getFoodHeatTypeList) { [self] result in
            print("111111 ---",Thread.current)
            sema.signal()
            group.leave()
            self.leftListArray.removeAll()
            
            switch result {
            case let .success(response):
                
                let jsonStr = JSON(response.data).description
                // print("JSON字符串---",jsonStr)
                let foodTypeListModel = FoodTypeListModel.deserialize(from: jsonStr)
                
                if foodTypeListModel?.code == 1 {
                    let data = foodTypeListModel?.data ?? [TypeListModel]()
                    // print("data---",data as Any)
                    
                    for (index, item) in data.enumerated() {
                        if index == 0 {
                            item.isSelected = true
                            self.typeId = String(item.id)
                            self.typeName = item.name
                        } else {
                            item.isSelected = false
                        }
                        self.leftListArray.append(item)
                    }
                    
                } else {
                    MBProgressHUD.show(foodTypeListModel?.msg , object: self)
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.leftTableView.reloadData()
                }
                
            case let .failure(error as NSError):
                print(error)
                self.leftTableView.reloadData()
            }
        }
        sema.wait()
    }
    //MARK: -- 获取分类下的食物列表
    func requestFoodHeatFoodList () {
        messageProvider.request(MessagePageApi.getFoodHeatFoodList(id: self.typeId, page: self.page)) { result in
            self.rightListArray.removeAll()
            switch result {
            case let .success(response):
                
                let jsonStr = JSON(response.data).description
                print("JSON字符串---",jsonStr)
                let foodListModel = FoodListModel.deserialize(from: jsonStr)

                if foodListModel?.code == 1 {
                    let foodDataModel = foodListModel?.data ?? FoodDataModel()
                    print("data---",foodDataModel as Any)
                    let list = foodDataModel.list ?? [FoodDataListModel]()

                    for item in list {
                        
                        self.rightListArray.append(item)
                    }
                } else {
                    MBProgressHUD.show(foodListModel?.msg , object: self)
                }

                DispatchQueue.main.async {
                    self.rightTableView.reloadData()
                }
            case let .failure(error as NSError):
                print(error)
                self.rightTableView.reloadData()
            }
        }
    }
}

extension MessageFoodPageVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.leftTableView == tableView {
            
            return self.leftListArray.count
        } else {
            
            return self.rightListArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.leftTableView == tableView {
            
            let leftCell = LeftTableViewCell.cellWithTableView(tableView)
            
            let typeListModel = self.leftListArray[indexPath.row] as! TypeListModel?
            
            leftCell?.configFoodTypeListModel(typeListModel!)
            
            return leftCell!
        } else {
            
            let rightCell = RightTableViewCell.cellWithTableView(tableView)
            let foodListModel = self.rightListArray[indexPath.row] as! FoodDataListModel?
            
            rightCell?.configFoodDataListModel(foodListModel!)
            
            return rightCell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.leftTableView == tableView {
            return 80
        } else {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.leftTableView == tableView {
            return UIView()
        } else {
            let headerView = UIView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth - 80, height: 30))
            
            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 14.0)
            titleLabel.textColor = .subFontColor
            titleLabel.text = self.typeName
            headerView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in
                make.left.equalTo(15)
                make.centerY.equalTo(headerView.snp_centerY)
                make.width.equalTo(kScreenWidth - 110)
                make.height.equalTo(20)
            }
            
            
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.leftTableView == tableView {
            return 0.01
        } else {
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if self.leftTableView == tableView {
            return UIView()
        } else {
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.leftTableView == tableView {
            return 0.01
        } else {
            return 0.01
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.leftTableView == tableView {
            let typeListModel = self.leftListArray[indexPath.row] as! TypeListModel?
            
            for item in self.leftListArray {
    
                if (item as! TypeListModel).id == typeListModel?.id {
                    (item as! TypeListModel).isSelected = true
                } else {
                    (item as! TypeListModel).isSelected = false
                }
            }
            
            self.leftTableView.reloadData()
            
            self.typeId = String(typeListModel!.id)
            self.typeName = typeListModel!.name
            self.requestFoodHeatFoodList()
        } else {
           
        }
    }
}
