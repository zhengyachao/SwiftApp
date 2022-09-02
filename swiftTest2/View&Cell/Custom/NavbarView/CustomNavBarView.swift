//
//  CustomNavBarView.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/9/2.
//

import UIKit

class CustomNavBarView: UIView {
    
    var topSafeMargin : CGFloat = 20
    
    var clickBackBtnBlock: (()->Void)?

    lazy var backBtn: UIButton = {
        let backBtn = UIButton()
        backBtn.setImage(UIImage(named: "back"), for: .normal)
        backBtn.addTarget(self, action: #selector(onClickBackBtn(_:)), for: .touchUpInside)
        return backBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.addSubview(backBtn)
        
        if #available(iOS 11.0, *) {
            if UIApplication.shared.windows[0].safeAreaInsets.bottom > 0 {
                topSafeMargin = UIApplication.shared.windows[0].safeAreaInsets.top
            }
        }
       
        backBtn.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(topSafeMargin)
            make.width.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onClickBackBtn(_ btn : UIButton) {
        clickBackBtnBlock?()
    }
    
}
