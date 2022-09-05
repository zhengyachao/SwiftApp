//
//  LeftTableViewCell.swift
//  hangge_2258
//
//  Created by hangge on 2019/1/8.
//  Copyright © 2019年 hangge. All rights reserved.
//

import UIKit
import Kingfisher

//左侧表格的自定义单元格
class LeftTableViewCell: UITableViewCell {
  
    //左侧装饰标签
    lazy var leftTag: UIView = {
        let leftTag = UIView()
        leftTag.backgroundColor = .theme
        return leftTag
    }()
    
    lazy var rightView: UIView = {
        let rightView = UIView()
        return rightView
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        return iconImageView
    }()
    
    //标题文本标签
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.textColor = .smallFontColor
        titleLabel.font = UIFont.systemFont(ofSize: 10)
        return titleLabel
    }()
    
    class func cellWithTableView (_ tableView: UITableView) -> Self! {
        
        let identifier = "LeftTableViewCell_Id"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            cell = LeftTableViewCell.init(style: .subtitle, reuseIdentifier: identifier)
        }
        
        return cell as? Self
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.backgroundColor = .background
        
        setUpCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCellUI () {
        contentView.addSubview(self.leftTag)
        contentView.addSubview(self.rightView)
        self.rightView.addSubview(self.iconImageView)
        self.rightView.addSubview(self.titleLabel)
        
        self.leftTag.snp.makeConstraints { make in
            make.left.equalTo(5)
            make.centerY.equalTo(contentView)
            make.width.equalTo(5)
            make.height.equalTo(20)
        }
        
        self.rightView.snp.makeConstraints { make in
            make.left.equalTo(self.leftTag.snp_right).offset(5)
            make.top.right.bottom.equalTo(contentView)
        }
        
        self.iconImageView.snp.makeConstraints { make in
            make.bottom.equalTo(self.rightView.snp_centerY)
            make.centerX.equalTo(self.rightView.snp_centerX)
            make.width.height.equalTo(30)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.rightView.snp_centerY).offset(5)
            make.left.right.equalTo(self.rightView)
            make.height.equalTo(20)
        }
    }
    
    //设置数据
    func configFoodTypeListModel(_ model : TypeListModel) {
        
        leftTag.isHidden = model.isSelected ? false : true
        
        titleLabel.text = model.name
        titleLabel.textColor = model.isSelected ? UIColor.mainFontColor : UIColor.smallFontColor
        /*
         Kingfisher 加载网络图片的时候报错： “No exact matches in call to instance method 'setImage'”
         这个错误是出在url的写法上了
         */
        iconImageView.kf.setImage(with: URL(string: model.icon))
        
    }
}

