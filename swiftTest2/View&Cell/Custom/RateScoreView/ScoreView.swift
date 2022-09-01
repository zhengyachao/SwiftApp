//
//  ScoreView.swift
//  Swift_SPAlertController
//
//  Created by lidongxi on 2020/1/13.
//  Copyright © 2020 lidongxi. All rights reserved.
//

import UIKit

class ScoreView: UIView {

    var submitClickedClosure: (()->Void)?
    var cancelClickedClosure: (()->Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(starRatingView)
        self.addSubview(lineView)
        self.addSubview(cancelButton)
        self.addSubview(verticalLineView)
        self.addSubview(submitButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func submitButtonAction() {
        submitClickedClosure?()
    }
    
    @objc func cancelButtonAction() {
        cancelClickedClosure?()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
         
        // 星星
        starRatingView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
        starRatingView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40).isActive = true
        starRatingView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        starRatingView.bottomAnchor.constraint(equalTo: lineView.topAnchor, constant: 0).isActive = true
        starRatingView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // 线
        let lineH: CGFloat = 1.0/UIScreen.main.scale
        lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        lineView.bottomAnchor.constraint(equalTo: submitButton.topAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: lineH).isActive = true
        
        // 取消按钮
        cancelButton.snp.makeConstraints { make in
            make.left.bottom.equalTo(self)
            make.right.equalTo(self.snp_centerX)
            make.height.equalTo(50)
        }
        
        verticalLineView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(cancelButton.snp_centerY)
            make.width.equalTo(1)
            make.height.equalTo(50)
        }
        
        // 提交按钮
        submitButton.snp.makeConstraints { make in
            make.right.bottom.equalTo(self)
            make.left.equalTo(self.snp_centerX)
            make.height.equalTo(50)
        }
    }
    
    lazy var starRatingView: SwiftyStarRatingView = {
        let starRatingV = SwiftyStarRatingView()
        starRatingV.translatesAutoresizingMaskIntoConstraints = false
        starRatingV.maximumValue = 5
        starRatingV.minimumValue = 0
        starRatingV.value = 2
        starRatingV.spacing = 20
        starRatingV.tintColor = UIColor.init(red: 0.0, green: 0.48, blue: 1.0, alpha: 1.0)
        starRatingV.allowsHalfStars = false
        return starRatingV
    }()
    
    lazy var lineView: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor.lightGray
        line.alpha = 0.3
        return line
    }()

    lazy var submitButton: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.white
        let titleColor = UIColor.init(red: 0.0, green: 0.48, blue: 1.0, alpha: 1.0)
        btn.setTitleColor(titleColor, for: .normal)
        btn.setTitle("提交", for: .normal)
        btn.addTarget(self, action: #selector(submitButtonAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var verticalLineView: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor.lightGray
        line.alpha = 0.3
        return line
    }()
    
    lazy var cancelButton: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.white
        let titleColor = UIColor.init(red: 0.0, green: 0.48, blue: 1.0, alpha: 1.0)
        btn.setTitleColor(titleColor, for: .normal)
        btn.setTitle("取消", for: .normal)
        btn.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        return btn
    }()
    
}
