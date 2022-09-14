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
    
    class func cellWithTableView (_ tableView: UITableView, indexPath: IndexPath) -> Self! {
        /*
         在iOS9.3和iOS8.1下测试，只要为tableview注册了相应的cell类，无论用两种方法中的哪一种，都不用手动创建就能获得cell，不会为nil。
         然而如果没有为tableview注册cell类，则dequeueReusableCellWithIdentifier:forIndexPath:会crash，crash原因为
         “must register a nib or a class for the identifier or connect a prototype cell in a
         storyboard”，即dequeueReusableCellWithIdentifier:forIndexPath:方法必须与register方法配套使用。
         但如果没有为tableview注册cell类，dequeueReusableCellWithIdentifier:方法也不会崩溃，只是会返回nil，此时需要我们手动创建cell，
         如果未创建，则程序会crash，crash原因为“UITableView failed to obtain a cell from its dataSource”，即此时tableView无法获取到cell实例。
         */
        let identifier = "MessageDailyListCell_Id"
        
        //MARK: -- 方法1使用dequeueReusableCellWithIdentifier:forIndexPath:但是必须要先注册cell 否则会崩溃
        //tableView.register(MessageDailyListCell.self, forCellReuseIdentifier: identifier)
        //var cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        //MARK: -- 方法2使用dequeueReusableCellWithIdentifier:会返回nil
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
        // 毛玻璃 模糊效果
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        bgView.addSubview(blurView)
        blurView.snp.makeConstraints { make in
            make.edges.equalTo(bgView)
        }
        bgView.insertSubview(blurView, at: 0)
    
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
        
        self.authorLabel.text = listModel.author.isEmpty ? "--" + "未知作者" : "--" + listModel.author
    }
    
    class func configMessageDailyListCellHeight (_ listModel:Daily_wordModel) -> CGFloat {
        
        let contentHeight = listModel.content.textAutoHeight(width: kScreenWidth - 40, font: UIFont.systemFont(ofSize: 16.0))
        
        let cellHeight = 10 + 10 + contentHeight + 10 + 15 + 10 
        
        return cellHeight
    }
}
