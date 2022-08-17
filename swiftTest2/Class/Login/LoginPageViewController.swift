//
//  LoginPageViewController.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/17.
//

import UIKit

class LoginPageViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 23/255, green: 133/255, blue: 170/255, alpha: 0.3)
        // Do any additional setup after loading the view.
        self.initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    

    func initUI() {
        // Mark --- 账号
        let accountTf = UITextField.init(frame: CGRect.zero)
        accountTf.placeholder = "请输入账号"
        accountTf.borderStyle = .roundedRect
        accountTf.clearButtonMode = .whileEditing
        self.view.addSubview(accountTf)
        accountTf.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.snp_centerY).offset(-54)
            make.left.equalTo(30)
            make.width.equalTo(kScreenWidth - 60)
            make.height.equalTo(44)
        }

        let leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 44))
        let leftLabel = UILabel.init(frame: CGRect.init(x: 10, y: 0, width: 50, height: 44))
        leftLabel.text = "账号:"
        leftLabel.textColor = UIColor.mainFontColor
        leftLabel.font = UIFont.systemFont(ofSize: 18)
        leftView.addSubview(leftLabel)
        accountTf.leftView = leftView
        accountTf.leftViewMode = .always
        accountTf.delegate = self

        // Mark --- 密码
        let pwdTf = UITextField.init(frame: CGRect.zero)
        pwdTf.placeholder = "请输入密码"
        pwdTf.borderStyle = .roundedRect
        pwdTf.clearButtonMode = .whileEditing
        self.view.addSubview(pwdTf)
        pwdTf.snp.makeConstraints { make in
            make.top.equalTo(accountTf.snp_bottom).offset(20)
            make.left.equalTo(30)
            make.width.equalTo(kScreenWidth - 60)
            make.height.equalTo(44)
        }

        let leftPwdView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 44))
        let leftPwdLabel = UILabel.init(frame: CGRect.init(x: 10, y: 0, width: 50, height: 44))
        leftPwdLabel.text = "密码:"
        leftPwdLabel.textColor = UIColor.mainFontColor
        leftPwdLabel.font = UIFont.systemFont(ofSize: 18)
        leftPwdView.addSubview(leftPwdLabel)
        pwdTf.leftView = leftPwdView
        pwdTf.leftViewMode = .always
        pwdTf.delegate = self
        
        let loginBtn = UIButton()
        loginBtn.backgroundColor = UIColor.theme
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        loginBtn.layer.cornerRadius = 5.0
        loginBtn.addTarget(self, action: #selector(onClickLoginBtn), for: .touchUpInside)
        self.view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { make in
            make.top.equalTo(pwdTf.snp_bottom).offset(20)
            make.left.equalTo(30)
            make.width.equalTo(kScreenWidth - 60)
            make.height.equalTo(44)
        }
    }
    
    // MARK -- 登录按钮
    @objc func onClickLoginBtn () {
        kUserDefaults.set(true, forKey: kIsLogin)
        kUserDefaults.synchronize()
        
        /// 跳转到Tabbar页
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = YCTabbarViewController()
    }
}