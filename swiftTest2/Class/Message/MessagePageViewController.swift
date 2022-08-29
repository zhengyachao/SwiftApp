//
//  MessagePageViewController.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/17.
//

import UIKit

class MessagePageViewController: UIViewController {

    var dataArray = ["1"]
    var isUpdate = false
    
    lazy var msgTabelView: UITableView = {
        
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = 70
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.background
        
//        let ary = ["1"]
//        print(ary[2])
        
        view.addSubview(msgTabelView)
        msgTabelView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        // 下来刷新
        addTableViewRefresh()
    }
    
    func addTableViewRefresh () {
        
        msgTabelView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { [self] in
            msgTabelView.mj_header?.endRefreshing()
        })
    }
}

//MARK: -- 点击cell头像的代理
extension MessagePageViewController : MessageListTVCellProtocol {
    func tapBgImageView(isUpdate: Bool) {
        
        self.isUpdate = isUpdate
        self.msgTabelView.reloadData()
    }
}

//MARK: -- UITableViewDelegate,UITableViewDataSource
extension MessagePageViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let listCell = MessageListTVCell.cellWithTableView(tableView)
        
        listCell?.configMessageListTVCellModel(self.isUpdate)
        
        listCell?.tapBlock = { [weak self] isUpdated in

            self?.isUpdate = isUpdated
            self?.msgTabelView.reloadData()
        }        
//        listCell?.cellDelegate = self
        
        return listCell!
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = MessageDetailPageVC()
        
        switch indexPath.row {
        case 0:
            detailVC.title = "每日一句"
        default: break
            
        }
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
