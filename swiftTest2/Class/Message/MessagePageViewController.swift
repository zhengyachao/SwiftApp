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
        tableView.tableViewNeverAdjustContentInset()
        
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
        
        listCell?.numLabel.text = String(indexPath.row)
        
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
        
        
        
        switch indexPath.row {
        case 0:
            let dailyVC = MessageDetailPageVC()
            dailyVC.title = "每日一句"
            self.navigationController?.pushViewController(dailyVC, animated: true)
        case 1:
            let newsVC = MessageNewsPageVC()
            newsVC.title = "新闻"
            self.navigationController?.pushViewController(newsVC, animated: true)
        case 2:
            let lottieVC = MessageLottiePageVC()
            self.navigationController?.pushViewController(lottieVC, animated: true)
        case 3:
            self.showRateView()
        case 4:
            self.showRateStarView()
        case 5:
            let dataVC = MessageDataViewController()
            self.navigationController?.pushViewController(dataVC, animated: true)
        case 6:
            let fileVC = MessageFileManagerVC()
            self.navigationController?.pushViewController(fileVC, animated: true)
        case 7:
            let imageVC = MessageImageListVC()
            self.navigationController?.pushViewController(imageVC, animated: true)
        case 8:
            let foodVC = MessageFoodPageVC()
            self.navigationController?.pushViewController(foodVC, animated: true)
        default: break
            
        }
    }
    
    func showRateStarView() {
//        let bgView = UIView()
//        bgView.backgroundColor = .black.withAlphaComponent(0.5)
//        let window = UIApplication.shared.delegate?.window
//        window??.addSubview(bgView)
//        bgView.snp.makeConstraints { make in
//            make.edges.equalTo(window!!)
//        }

        let rateView = BJRateStarView()
        self.view.addSubview(rateView)
        rateView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self.view)
            make.width.height.equalTo(58+105+105)
        }
    }
    
    func showRateView () {
        // scoreview的子控件采用的是自动布局，由于高度上能够由子控件撑起来，所以高度可以给0，如果宽度也能撑起，宽度也可以给0
        let scoreView = ScoreView.init(frame: CGRect.init(x: 0, y: 0, width: 275, height: 0))
        scoreView.backgroundColor = .white
        scoreView.submitClickedClosure = { [weak self] in
            self?.presentedViewController?.dismiss(animated: true, completion: nil)
        }
        
        scoreView.cancelClickedClosure = { [weak self] in
            self?.presentedViewController?.dismiss(animated: true, completion: nil)
        }
        
        let alertController = SPAlertController.alertController(withCustomActionSequenceView: scoreView, title: "提示", message: "请给我们的app打分", preferredStyle: .alert, animationType: .default)
        alertController.image = UIImage.init(named: "empty")
        
        alertController.needDialogBlur = true
        
        self.present(alertController, animated: true, completion: nil)
    }
}
