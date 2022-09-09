//
//  YCPatternLockVC.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/9/1.
//

import UIKit

class YCPatternLockVC: YCBaseViewController {

    private var currentPassword: String = ""  // 当前手势密码
    private var firstPassword: String = ""    // 第一次手势密码
    private var secondPassword: String = ""   // 第二次手势密码
    
    let config = LockViewConfig()
    
    lazy var lockView: PatternLockView = {
        let lockView = PatternLockView(config: config)
        lockView.delegate = self
        return lockView
    }()
    
    lazy var tipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.textColor = .mainFontColor
        tipLabel.textAlignment = .center
        tipLabel.font = UIFont.systemFont(ofSize: 14.0)
        tipLabel.text = "绘制解锁图案"
        return tipLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "手势密码"

        // Do any additional setup after loading the view.
        view.addSubview(tipLabel)
        view.addSubview(lockView)
        tipLabel.snp.makeConstraints { make in
            make.left.top.equalTo(15)
            make.width.equalTo(kScreenWidth - 30)
            make.height.equalTo(20)
        }
        
        lockView.snp.makeConstraints { make in
            make.left.equalTo(40)
            make.width.height.equalTo(kScreenWidth - 80)
            make.centerY.equalTo(view)
        }
    }
    //MARK: -- 设置密码
    func setupPassword() {
        if firstPassword.isEmpty {
            firstPassword = currentPassword
        } else
        {
            secondPassword = currentPassword
            if firstPassword == secondPassword {
                
                MBProgressHUD.show("手势密码设置成功", object: self)
                kUserDefaults.set(secondPassword, forKey: "kFirstPassword")
            } else
            {
                MBProgressHUD.show("与上次绘制不一致，请重新绘制", object: self)
                secondPassword = ""
            }
        }
    }
}

//MARK: -- PatternLockViewDelegate
extension YCPatternLockVC: PatternLockViewDelegate {
    
    func lockView(_ lockView: PatternLockView, didConnectedGrid grid: PatternLockGrid) {
        // eg: 31457
        currentPassword += grid.identifier
    }
    
    func lockViewShouldShowErrorBeforeConnectCompleted(_ lockView: PatternLockView) -> Bool {
        if firstPassword.isEmpty {
            //第一次密码还未配置，不需要显示error
            return false
        }else if firstPassword == currentPassword {
            //两次输入的密码相同，不需要显示error
            return false
        }else {
            return true
        }
    }
    
    func lockViewDidConnectCompleted(_ lockView: PatternLockView) {
        if currentPassword.count < 4 {
            MBProgressHUD.show("至少连接4个点，请重新输入", object: self)
        } else {
            self.setupPassword()
        }
        
        currentPassword = ""
        print("currentPassword",currentPassword)
    }
}
