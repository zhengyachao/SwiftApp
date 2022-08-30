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

class MessageNewsListVC: UIViewController {
    var page = 1
    var typeId = String()
    
    lazy var dataArray = Array<Any>()
    lazy var dataDict = Dictionary<String,String>()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableViewNeverAdjustContentInset()
        tableView.addEmptyDataSetView()
        tableView.separatorStyle = .none
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        // 下拉刷新数据
        addRefreshTableView()
        // 获取新闻列表Api
        requestNewsListApi()
    }
    
    //MARK: -- 刷新数据
    func addRefreshTableView () {
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            // print("当前线程---",Thread.current)
            self.page = 1
            self.requestNewsListApi()
        })
        
        self.tableView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            self.page += 1
            self.requestNewsListApi()
        })
    }
    
    //MARK: -- 根据新闻类型获取新闻列表Api
    func requestNewsListApi() {
        // print("typeId------",self.typeId)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        messageProvider.request(MessagePageApi.getNewsList(typeId: self.typeId, page: self.page)) { result in
            MBProgressHUD.hide(for: self.view, animated: true)
            if self.page == 1 {
                self.dataArray.removeAll()
            }
            
            switch result {
            case let .success(response):
                
                let jsonStr = JSON(response.data).description
                // print("JSON字符串---",jsonStr)
                
                let listModel = NewsListModel.deserialize(from: jsonStr)
                let datas = listModel?.data ?? [NewsListDataModel]()
                
                for item in datas {
                    self.dataArray.append(item)
                }
                
                self.tableView.reloadData()
                self.tableView.mj_header?.endRefreshing()
                self.tableView.mj_footer?.endRefreshing()
                
            case let .failure(error as NSError):
                print(error)
                self.tableView.reloadData()
                self.tableView.mj_header?.endRefreshing()
                self.tableView.mj_footer?.endRefreshing()
            }
        }
    }
}

extension MessageNewsListVC : JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        
        return view
    }
}

extension MessageNewsListVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let listCell = MessageNewsListCell.cellWithTableView(tableView)
        let listModel = self.dataArray[indexPath.row] as! NewsListDataModel
        listCell?.configMessageNewsListCellModel(listModel)
        return listCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let listModel = self.dataArray[indexPath.row] as! NewsListDataModel

        return MessageNewsListCell.configMessageNewsListCellHeight(listModel)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let listModel = self.dataArray[indexPath.row] as! NewsListDataModel

        let detailVC = MessageNewsDetailVC()
        
        detailVC.newsId = listModel.newsId
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
