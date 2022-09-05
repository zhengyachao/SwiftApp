//
//  RightTableViewCell.swift
//  hangge_2258
//
//  Created by hangge on 2019/1/8.
//  Copyright © 2019年 hangge. All rights reserved.
//

import UIKit

//右侧表格的自定义单元格
class RightTableViewCell: UITableViewCell {
    
    //标题文本标签
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .mainFontColor
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        return titleLabel
    }()
    
    // 卡路里
    lazy var caloryLabel: UILabel = {
        let caloryLabel = UILabel()
        caloryLabel.textAlignment = .right
        caloryLabel.textColor = .smallFontColor
        caloryLabel.font = UIFont.systemFont(ofSize: 12)
        return caloryLabel
    }()
    
    class func cellWithTableView (_ tableView: UITableView) -> Self! {
        
        let identifier = "RightTableViewCell_Id"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            cell = RightTableViewCell.init(style: .subtitle, reuseIdentifier: identifier)
        }
        
        return cell as? Self
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setUpCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCellUI () {
        contentView.addSubview(self.titleLabel)
        contentView.addSubview(self.caloryLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.centerY.equalTo(contentView.snp_centerY)
            make.width.equalTo(kScreenWidth - 140)
            make.height.equalTo(20)
        }
        
        self.caloryLabel.snp.makeConstraints { make in
            make.right.equalTo(contentView.snp_right).offset(-15)
            make.centerY.equalTo(contentView.snp_centerY)
            make.width.equalTo(kScreenWidth - 140)
            make.height.equalTo(20)
        }
    }
    
    //设置数据
    func configFoodDataListModel(_ model : FoodDataListModel) {
        
        titleLabel.text = model.name
        
        caloryLabel.text = model.calory + "卡"
    }
}
