//
//  CustomMaskView.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/9/16.
//

import UIKit

typealias InputClosureType = (_ str:String) -> Void   //定义闭包类型（特定的函数类型函数类型）

class CustomMaskView: UIView {

    var backClosure :InputClosureType?
    //闭包变量的Seter方法
    func setBackMyClosure(tempClosure:@escaping InputClosureType) {
        self.backClosure = tempClosure
    }
    
//    func testBlock1(testBlock:@escaping InputClosureType) -> Void {
//        self.backClosure = testBlock
//    }
   
    
    var clickCancelBlock: ((_ btn:UIButton)->Void)? = {_ in}
    var clickSubmitBlock: ((_ btn:UIButton)->Void)? = {_ in}
    
    var title:String
    var detail:String
    
    init(frame: CGRect,title: String,detail:String) {
        self.title = title
        self.detail = detail
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        kAppDelegate.window?.addSubview(self)
        self.snp.makeConstraints { make in
            make.edges.equalTo(kAppDelegate.window!)
        }
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(hide))
        self.addGestureRecognizer(tap)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView()  {
        self.addSubview(self.bgView)
        self.bgView.addSubview(self.titleLabel)
        self.bgView.addSubview(self.detailLabel)
        self.bgView.addSubview(self.cutLine)
        self.bgView.addSubview(self.cancelButton)
        self.bgView.addSubview(self.verticalLineView)
        self.bgView.addSubview(self.submitButton)
        
        self.bgView.snp.makeConstraints { make in
            make.left.equalTo(60)
            make.right.equalTo(self.snp_right).offset(-60)
            make.centerY.equalTo(self)
            make.height.equalTo(160)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.left.right.equalTo(self.bgView)
            make.height.equalTo(20)
        }
        
        self.detailLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp_bottom).offset(15)
            make.left.equalTo(15)
            make.right.equalTo(self.bgView.snp_right).offset(-15)
        }
        
        self.cutLine.snp.makeConstraints { make in
            make.bottom.equalTo(self.bgView.snp_bottom).offset(-44)
            make.left.right.equalTo(self.bgView)
            make.height.equalTo(1)
        }
        
        self.cancelButton.snp.makeConstraints { make in
            make.left.bottom.equalTo(self.bgView)
            make.right.equalTo(self.bgView.snp_centerX)
            make.height.equalTo(44)
        }
        
        self.verticalLineView.snp.makeConstraints { make in
            make.top.equalTo(self.cutLine.snp_bottom)
            make.centerX.equalTo(self.bgView.snp_centerX)
            make.bottom.equalTo(self.bgView.snp_bottom)
            make.width.equalTo(1)
        }
        
        self.submitButton.snp.makeConstraints { make in
            make.right.bottom.equalTo(self.bgView)
            make.left.equalTo(self.bgView.snp_centerX)
            make.height.equalTo(44)
        }
        
        self.titleLabel.text = self.title
        self.detailLabel.text = self.detail
    }
  
    func show() {
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1.0
        }, completion: nil)
    }
    
    @objc func hide() {
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
        }) { Bool in
            self.removeFromSuperview()
        }
    }
    
    @objc func cancelButtonAction (_ btn:UIButton) {
        self.clickCancelBlock!(btn)
        self.backClosure!("2222")
    }
    
    @objc func submitButtonAction (_ btn:UIButton) {
        self.clickSubmitBlock!(btn)
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 10.0
        bgView.clipsToBounds = true
        
        return bgView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .mainFontColor
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    lazy var detailLabel: UILabel = {
        let detailLabel = UILabel()
        detailLabel.textColor = .subFontColor
        detailLabel.font = UIFont.systemFont(ofSize: 14)
        detailLabel.numberOfLines = 0
        detailLabel.preferredMaxLayoutWidth = kScreenWidth - 150
        return detailLabel
    }()
    
    lazy var cutLine: UIView = {
        let cutLine = UIView()
        cutLine.backgroundColor = .background
        return cutLine
    }()
    
    //左边取消按钮
    lazy var cancelButton: UIButton = {
        let btn = UIButton.init(type: .custom)
        let titleColor = UIColor.smallFontColor
        btn.setTitleColor(titleColor, for: .normal)
        btn.setTitle("取消", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        btn.addTarget(self, action: #selector(cancelButtonAction(_:)), for: .touchUpInside)
        return btn
    }()
    
    //按钮分割线
    lazy var verticalLineView: UIView = {
        let line = UIView()
        line.backgroundColor = .background
        return line
    }()
    
    //右边按钮
    lazy var submitButton: UIButton = {
        let btn = UIButton.init(type: .custom)
        let titleColor = UIColor.init(red: 0.0, green: 0.48, blue: 1.0, alpha: 1.0)
        btn.setTitleColor(titleColor, for: .normal)
        btn.setTitle("提交", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        btn.addTarget(self, action: #selector(submitButtonAction(_:)), for: .touchUpInside)
        return btn
    }()
}
