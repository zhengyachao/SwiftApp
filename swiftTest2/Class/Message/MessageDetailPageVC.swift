//
//  MessageDetailPageVC.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/19.
//

import UIKit
import SwiftyJSON
import HandyJSON

class MessageDetailPageVC: YCBaseViewController {
    /*
     初始化一个Any类型的空Array，此处必须指定类型，否则会报编译错误
     var emptyArray = Array<Any>()
     var emptyArray1: [Any] = Array()
     var emptyArray2: Array<Any> = Array()
     var emptyArray3 = [Any]()
     */
    lazy var dataArray = Array<Any>()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addEmptyDataSetView()
        tableView.tableViewNeverAdjustContentInset()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var pageNum = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        // 每日一句接口
        requestDaily_wordRecommend(count: 10)
        // 添加下拉刷新
        addRefreshTableView()
    }
    //MARK: -- 添加下拉刷新
    func addRefreshTableView () {
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {[weak self] in
            self?.pageNum = 1
            self?.requestDaily_wordRecommend(count: 10)
        })
        
        self.tableView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {[weak self] in
            self?.pageNum += 1
            self?.requestDaily_wordRecommend(count: 10)
        })
    }
    
    //MARK: -- 网络请求
    func requestDaily_wordRecommend(count : Int) -> Void {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        messageProvider.request(MessagePageApi.getDaily_wordRecommend(page: self.pageNum, count: count, app_id: kAppId, app_secret: kAppSecret)) { result in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            if self.pageNum == 1 {
                
                self.dataArray.removeAll()
            }
            
            switch result {
            case let .success(response):
                
                let jsonStr = JSON(response.data).description
                print("JSON字符串---",jsonStr)
                let messageModel = MessageTestModel.deserialize(from: jsonStr)
                
                if messageModel?.code == 1 {
                    
                    let data = messageModel?.data ?? [Daily_wordModel]()
                    
                    for daily_wordModel in data {
                        self.dataArray.append(daily_wordModel)
                    }
                    
                } else {
                    MBProgressHUD.show(messageModel?.msg, object: self)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.tableView.mj_header?.endRefreshing()
                    self.tableView.mj_footer?.endRefreshing()
                }
                
            case let .failure(error as NSError):
                print(error)
                self.tableView.reloadData()
                self.tableView.mj_header?.endRefreshing()
                self.tableView.mj_footer?.endRefreshing()
            }
        }
    }
}

extension MessageDetailPageVC : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let listCell = MessageDailyListCell.cellWithTableView(tableView, indexPath: indexPath)
        
//        let listModel = self.dataArray[indexPath.row]
//        listCell?.configMessageDailyListCellModel(listModel as! Daily_wordModel)
        
        return listCell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let listCell = cell as? MessageDailyListCell else {
            return
        }
        
        let listModel = self.dataArray[indexPath.row]
        listCell.configMessageDailyListCellModel(listModel as! Daily_wordModel)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let listModel = self.dataArray[indexPath.row]
        return MessageDailyListCell.configMessageDailyListCellHeight(listModel as! Daily_wordModel)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}
