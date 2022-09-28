//
//  YCBaseViewController.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/17.
//

import UIKit

class YCBaseViewController: UIViewController {
    //MARK: -- 自定义返回按钮替换系统默认返回按钮
    lazy var backBtn: ZYButton = {
        let backBtn = ZYButton.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        backBtn.setImage(UIImage(named: "common_back_btn"), for: .normal)
        backBtn.setImage(UIImage(named: "common_back_btn"), for: .highlighted)
        backBtn.setTitle("返回", for: .normal)
        backBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        backBtn.addTarget(self, action: #selector(onClickBackBtn(_:)), for: .touchUpInside)
        return backBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        
        // 设置返回按钮
        setupBackBtn()
    }
    
    //MARK: -- 统一设置二级页面以上页的返回按钮
    func setupBackBtn () {
        
        let backItem = UIBarButtonItem.init(customView: self.backBtn)
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    //MARK: -- 返回按钮点击方法 子类可重写
    @objc open func onClickBackBtn(_ btn:UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
}
