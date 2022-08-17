//
//  MinePageViewController.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/17.
//

import UIKit

class MinePageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.background
        
        let logoutBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        logoutBtn.setTitle("退出", for: .normal)
        logoutBtn.setTitleColor(UIColor.white, for: .normal)
        logoutBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        logoutBtn.addTarget(self, action: #selector(onClickLogoutBtn), for: .touchUpInside)
        let rightItem = UIBarButtonItem.init(customView: logoutBtn)
        self.navigationItem.rightBarButtonItem = rightItem

    }
    
    @objc func onClickLogoutBtn () {
        // 退出登录通知
        kNotificationCenter.post(name: NSNotification.Name(kLogoutSuccessNotice), object: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
