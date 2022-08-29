//
//  MessageDailyListCell.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/29.
//

import UIKit

class MessageDailyListCell: UITableViewCell {

    lazy var bgView = UIView()
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
        contentView.addSubview(bgView)
        bgView.backgroundColor = UIColor.random
        bgView.layer.cornerRadius = 5.0;
        bgView.clipsToBounds = true
        bgView.snp.makeConstraints { make in
            make.top.left.equalTo(10)
            make.width.equalTo(kScreenWidth - 20)
            make.bottom.equalTo(contentView)
        }
    
        bgView.addSubview(contentLabel)
        bgView.addSubview(authorLabel)
        
        contentLabel.numberOfLines = 0;
        contentLabel.font = UIFont.systemFont(ofSize: 16)
        contentLabel.textColor = UIColor.white
        contentLabel.snp.makeConstraints { make in
            make.top.left.equalTo(bgView).offset(10)
            make.width.equalTo(kScreenWidth - 40)
        }
        
        authorLabel.font = UIFont.systemFont(ofSize: 12)
        authorLabel.textColor = UIColor.white
        authorLabel.textAlignment = .right
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentLabel.snp_bottom).offset(10)
            make.right.equalTo(bgView).offset(-10)
            make.width.equalTo(140)
            make.height.equalTo(15)
        }
    }

    func configMessageDailyListCellModel (_ listModel:Daily_wordModel) {
        
        self.contentLabel.text = listModel.content.isEmpty ? "暂无数据" :listModel.content
        
        self.authorLabel.text = listModel.author.isEmpty ? "未知作者" :listModel.author
    }
    
    class func configMessageDailyListCellHeight (_ listModel:Daily_wordModel) -> CGFloat {
        
        let contentHeight = listModel.content.textAutoHeight(width: kScreenWidth - 40, font: UIFont.systemFont(ofSize: 16.0))
        
        let cellHeight = 10 + 10 + contentHeight + 10 + 15 + 10 
        
        return cellHeight
    }
}
