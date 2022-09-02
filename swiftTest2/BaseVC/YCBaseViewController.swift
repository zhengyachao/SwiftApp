//
//  YCBaseViewController.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/17.
//

import UIKit

class YCBaseViewController: UIViewController {
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
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
        //
        setupBackBtn()
    }
    
    //MARK: 统一设置二级以上页的返回按钮
    func setupBackBtn () {
        
        let backItem = UIBarButtonItem.init(customView: self.backBtn)
        
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    //MARK: 返回按钮点击方法 子类可重写
    @objc open func onClickBackBtn(_ btn:UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
}
