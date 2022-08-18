//
//  MessageListTVCell.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/18.
//

import UIKit

class MessageListTVCell: UITableViewCell {
    // 图片
    lazy var bgImageView = UIImageView(frame: CGRect.zero)
    // 标题
    lazy var titleLabel  = UILabel(frame: CGRect.zero)
    // 详情
    lazy var detailLabel = UILabel(frame: CGRect.zero)
    // 日期
    lazy var timeLabel   = UILabel(frame: CGRect.zero)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func cellWithTableView (_ tableView: UITableView) -> Self! {
        
        /*
         static NSString *identifier = @"MobiNotifyListCell_Id";
         MobiNotifyListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
         if (cell == nil)
         {
             cell = [[MobiNotifyListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
         }
         return cell;
         */
        
        let identifier = "MessageListTVCell_Id"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            cell = MessageListTVCell.init(style: .subtitle, reuseIdentifier: identifier)
        }
        
        return cell as? Self
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setUpCellUI()
    }
    
    func setUpCellUI () {
        contentView.addSubview(bgImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(timeLabel)
        bgImageView.layer.cornerRadius = 25.0
        bgImageView.clipsToBounds = true
        bgImageView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.width.height.equalTo(50)
            make.centerY.equalTo(contentView.snp_centerY)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp_top)
            make.left.equalTo(bgImageView.snp_right).offset(10)
            make.width.equalTo(kScreenWidth - 70)
            make.height.equalTo(20)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp_bottom).offset(5)
            make.left.equalTo(bgImageView.snp_right).offset(10)
            make.width.equalTo(kScreenWidth - 70)
            make.height.equalTo(20)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp_top)
            make.right.equalTo(contentView).offset(-10)
            make.width.equalTo(140)
        }
    }
    
    func configMessageListTVCellModel () {
        
        bgImageView.image = UIImage.createImageWithColor(UIColor.theme, frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        
        titleLabel.text = "这是一个标题"
        titleLabel.textColor = UIColor.mainFontColor
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        
        detailLabel.text = "这是一个详情这是一个详情这是一个详情这是一个详情"
        detailLabel.textColor = UIColor.subFontColor
        detailLabel.font = UIFont.systemFont(ofSize: 12)
        
        timeLabel.text = "2022-08-18"
        timeLabel.textAlignment = .right
        timeLabel.textColor = UIColor.smallFontColor
        timeLabel.font = UIFont.systemFont(ofSize: 10)
    }
}
