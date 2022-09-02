//
//  BJRateStarView.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/9/1.
//

import UIKit

class BJRateStarView: UIView {

    var submitClickedClosure: (()->Void)?
    var cancelClickedClosure: (()->Void)?
    
    var isDark :Bool = false
    
    lazy var effectView: UIVisualEffectView = {
        let effectView = UIVisualEffectView()
        return effectView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        
        if #available(iOS 12.0, *) {
            isDark = self.traitCollection.userInterfaceStyle == .dark ? true : false
        }
        
        if (isDark) {
            self.backgroundColor = UIColor.init(r: 34/255, g: 34/255, b: 34/255, a: 0.8)
            self.line1.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            self.lineView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            self.verticalLineView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            self.titleLabel.textColor   = .white
            self.messageLabel.textColor = .white
        }
        
        let blurEffect = UIBlurEffect(style: isDark ? .dark: .light)
        effectView.effect = blurEffect
        self.addSubview(effectView)
    
        self.addSubview(iconImageView)
        self.addSubview(titleLabel)
        self.addSubview(messageLabel)
        self.addSubview(line1)
        self.addSubview(bgStarView)
        self.bgStarView.addSubview(starRatingView)
        self.addSubview(lineView)
        self.addSubview(cancelButton)
        self.addSubview(verticalLineView)
        self.addSubview(submitButton)
        
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        effectView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(58);
            make.top.equalTo(20);
            make.centerX.equalTo(self);
            make.bottom.equalTo(-172);
            make.leading.equalTo(105);
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(93);
            make.height.equalTo(22);
            make.centerX.equalTo(self);
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp_bottom).offset(2);
            make.leading.equalTo(25);
            make.centerX.equalTo(self);
        }
        
        line1.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self);
            make.bottom.equalTo(-86);
            make.height.equalTo(0.5);
        }
        
        bgStarView.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.height.equalTo(42);
            make.top.equalTo(self.line1.snp_bottom);
        }
        
        starRatingView.snp.makeConstraints { make in
            make.left.equalTo(25)
            make.right.equalTo(bgStarView).offset(-25)
            make.height.equalTo(42);
            make.top.equalTo(bgStarView);
        }
        
        lineView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self);
            make.bottom.equalTo(-43);
            make.height.equalTo(0.5);
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp_bottom);
            make.left.bottom.equalTo(self);
            make.width.equalTo(58+105+105);
        }
        
        verticalLineView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp_bottom);
            make.height.equalTo(cancelButton);
            make.centerX.equalTo(self);
            make.width.equalTo(0.5);
        }
        
        submitButton.snp.makeConstraints { make in
            make.right.bottom.equalTo(self);
            make.top.equalTo(cancelButton);
            make.left.equalTo(verticalLineView.snp_right);
        }
    }
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "empty")
        iconImageView.clipsToBounds = true
        return iconImageView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "提示"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.textAlignment = .center

        return titleLabel
    }()
    
    lazy var messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.text = "Tap a star to rate it on the App Store"
        messageLabel.textColor = .lightGray
        messageLabel.font = UIFont.systemFont(ofSize: 13)
        messageLabel.textAlignment = .center;
        messageLabel.numberOfLines = 0;
        return messageLabel
    }()
    
    lazy var line1: UIView = {
        let line1 = UIView()
        line1.translatesAutoresizingMaskIntoConstraints = false
        line1.backgroundColor = UIColor.lightGray
        line1.alpha = 0.3
        return line1
    }()
    
    lazy var bgStarView: UIView = {
        let bgStarView = UIView()
        bgStarView.backgroundColor = .white
        return bgStarView
    }()
    
    lazy var starRatingView: SwiftyStarRatingView = {
        let starRatingV = SwiftyStarRatingView()
        starRatingV.backgroundColor = .white.withAlphaComponent(0.9)
        starRatingV.maximumValue = 5
        starRatingV.minimumValue = 0
        starRatingV.value = 2
        starRatingV.spacing = 20
        starRatingV.tintColor = UIColor.init(red: 0.0, green: 0.48, blue: 1.0, alpha: 1.0)
        starRatingV.allowsHalfStars = false
        starRatingV.addTarget(self, action: #selector(changeStar), for: .valueChanged)

        return starRatingV
    }()
    
    lazy var lineView: UIView = {
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
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        btn.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var verticalLineView: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor.lightGray
        line.alpha = 0.3
        line.isHidden = true
        return line
    }()
       
    lazy var submitButton: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.white
        let titleColor = UIColor.init(red: 0.0, green: 0.48, blue: 1.0, alpha: 1.0)
        btn.setTitleColor(titleColor, for: .normal)
        btn.setTitle("提交", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        btn.addTarget(self, action: #selector(submitButtonAction), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
    

    @objc func submitButtonAction() {
        submitClickedClosure?()
    }
    
    @objc func cancelButtonAction() {
        cancelClickedClosure?()
        self.removeFromSuperview()
    }
    
    @objc func changeStar () {
        self.updateUI()
    }
    
    func updateUI () {
        self.cancelButton.snp.updateConstraints { make in
            make.width.equalTo(self.bounds.size.width/2.0);
        }
        
        self.verticalLineView.isHidden = false;
        self.submitButton.isHidden = false;
        self.cancelButton.setTitle("取消", for: .normal)
    }
    
//    @objc func onHide() {
//        self.removeFromSuperview()
//    }
}
