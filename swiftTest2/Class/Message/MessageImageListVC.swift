//
//  MessageImageListVC.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/9/2.
//

import UIKit
import SwiftyJSON
import Kingfisher

class MessageImageListVC: YCBaseViewController {

    lazy var listArray = Array<Any>()
    var page = 1
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isPagingEnabled = true
        tableView.separatorStyle = .none
        tableView.tableViewNeverAdjustContentInset()
        return tableView
    }()
    
    lazy var navbarView: CustomNavBarView = {
        let navbarView = CustomNavBarView()
        navbarView.backgroundColor = .clear
        // 返回
        navbarView.clickBackBtnBlock = { [weak self] in
            
            self?.navigationController?.popViewController(animated: true)
        }
        return navbarView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.isHidden = true

        view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        view.addSubview(self.navbarView)
        self.navbarView.snp.makeConstraints { make in
            make.left.top.right.equalTo(view)
            make.height.equalTo(kAppNavBarHeight)
        }
        
        // Do any additional setup after loading the view.
        requestGirlListApi()
        
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { [weak self] in
            self?.page = 1
            self?.requestGirlListApi()
        })
        
        self.tableView.mj_footer = MJRefreshBackFooter.init(refreshingBlock: { [weak self] in
            self?.page += 1
            self?.tableView.isPagingEnabled = false
            self?.requestGirlListApi()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.isHidden = false
    }
    //MARK: -- 网络请求
    func requestGirlListApi () {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        messageProvider.request(MessagePageApi.getGirlList(page: self.page)) { result in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            if self.page == 1 {
                self.listArray.removeAll()
            }
            
            switch result {
            case let .success(response):
                
                let jsonDict = JSON(response.data).dictionary
                print("JSON字符串---",jsonDict as Any)
                
                let code = jsonDict?["code"]
                let msg  = jsonDict?["msg"]?.string
//                let data = jsonDict?["data"]?.array
                let data: Array<Any> = (jsonDict?["data"]?.arrayObject)!

                if code == 1 {
                    for item in data {
                        let dict = item as! [String:Any]
                        self.listArray.append(dict["imageUrl"]!)
                    }
                } else {
                    MBProgressHUD.show( msg , object: self)
                }
                
                self.tableView.reloadData()
                self.tableView.mj_header?.endRefreshing()
                self.tableView.mj_footer?.endRefreshing { [weak self] in
                    // tableView设置isPagingEnabled 使用MJRefresh 导致分页错误偏移
                    self?.tableView.isPagingEnabled = true

                    if data.count > 0 {
                        self?.tableView.scrollToRow(at: IndexPath.init(row: (self!.page - 1) * 10, section: 0), at: .top, animated: false)
                    }
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

extension MessageImageListVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let listCell = MessageImageListCell.cellWithTableView(tableView)
        
//        listCell?.iconImageView.image = UIImage.createImageWithColor(.random, frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        listCell?.iconImageView.kf.setImage(with: URL.init(string: self.listArray[indexPath.row] as! String))
        
        return listCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kScreenHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}
