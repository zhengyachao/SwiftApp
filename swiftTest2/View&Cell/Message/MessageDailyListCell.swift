//
//  MessageDailyListCell.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/29.
//

import UIKit

class MessageDailyListCell: UITableViewCell {

    // 详情
    lazy var contentLabel = UILabel(frame: CGRect.zero)
    // 作者
    lazy var authorLabel   = UILabel(frame: CGRect.zero)

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func cellWithTableView (_ tableView: UITableView) -> Self! {
        
        let identifier = "MessageDailyListCell_Id"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            cell = MessageDailyListCell.init(style: .subtitle, reuseIdentifier: identifier)
        }
        
        return cell as? Self
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setUpCellUI()
    }
    
    func setUpCellUI () {
 
        contentView.addSubview(contentLabel)
        contentView.addSubview(authorLabel)

        contentLabel.numberOfLines = 0;
        contentLabel.font = UIFont.systemFont(ofSize: 16)
        contentLabel.textColor = UIColor.mainFontColor
        contentLabel.snp.makeConstraints { make in
            make.top.left.equalTo(contentView).offset(15)
            make.width.equalTo(kScreenWidth - 30)
        }
        
        authorLabel.font = UIFont.systemFont(ofSize: 12)
        authorLabel.textColor = UIColor.smallFontColor
        authorLabel.textAlignment = .right
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentLabel.snp_bottom).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.width.equalTo(140)
            make.height.equalTo(15)
        }
    }

    func configMessageDailyListCellModel (_ listModel:Daily_wordModel) {
        
        self.contentLabel.text = listModel.content.isEmpty ? "暂无数据" :listModel.content
        
        self.authorLabel.text = listModel.author.isEmpty ? "未知作者" :listModel.author
    }
    
    class func configMessageDailyListCellHeight (_ listModel:Daily_wordModel) -> CGFloat {
        
        let contentHeight = listModel.content.textAutoHeight(width: kScreenWidth - 30, font: UIFont.systemFont(ofSize: 16.0))
        
        let cellHeight = 15 + contentHeight + 10 + 15 + 15
        print("contentHeight --- %ld",contentHeight)
        print("cellHeight --- %ld",cellHeight)
        return cellHeight
    }
}
