//
//  MessageNewsListCell.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/30.
//

import UIKit
import Kingfisher

class MessageNewsListCell: UITableViewCell {

    lazy var titleLabel  = UILabel()
    lazy var digestLabel = UILabel()
    lazy var sourceLabel = UILabel()
    lazy var postTimeLabel = UILabel()
    lazy var imgListView = UIImageView()
    lazy var lineView = UIView()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    class func cellWithTableView (_ tableView: UITableView) -> Self! {
        
        let identifier = "MessageNewsListCell_Id"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            cell = MessageNewsListCell.init(style: .subtitle, reuseIdentifier: identifier)
        }
        
        return cell as? Self
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setUpCellUI()
    }
    
    func setUpCellUI () {
        contentView.addSubview(self.titleLabel)
        contentView.addSubview(self.sourceLabel)
        contentView.addSubview(self.postTimeLabel)
        contentView.addSubview(self.digestLabel)
        contentView.addSubview(self.imgListView)
        contentView.addSubview(self.lineView)
        
        self.titleLabel.textColor = .mainFontColor
        self.titleLabel.font = UIFont.systemFont(ofSize: 16.0)
        self.titleLabel.numberOfLines = 0
        self.titleLabel.preferredMaxLayoutWidth = kScreenWidth - 30
        self.titleLabel.snp.makeConstraints { make in
            make.top.left.equalTo(15)
            make.width.equalTo(kScreenWidth - 30)
        }
        
        self.sourceLabel.textColor = .subFontColor
        self.sourceLabel.font      = UIFont.systemFont(ofSize: 14.0)
        self.sourceLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp_bottom).offset(10)
            make.left.equalTo(15)
            make.height.equalTo(15)
        }
        
        self.postTimeLabel.textColor = .smallFontColor
        self.postTimeLabel.font = UIFont.systemFont(ofSize: 12)
        self.postTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp_bottom).offset(10)
            make.left.equalTo(self.sourceLabel.snp_right).offset(10)
            make.height.equalTo(15)
        }
        
        self.digestLabel.numberOfLines = 0
        self.digestLabel.preferredMaxLayoutWidth = kScreenWidth - 140
        self.digestLabel.textColor = .subFontColor
        self.digestLabel.font = UIFont.systemFont(ofSize: 14)
        self.digestLabel.snp.makeConstraints { make in
            make.top.equalTo(self.sourceLabel.snp_bottom).offset(10)
            make.left.equalTo(15)
            make.width.equalTo(kScreenWidth - 140)
        }
        
        self.imgListView.layer.cornerRadius = 5.0
        self.imgListView.contentMode = .scaleAspectFill
        self.imgListView.clipsToBounds = true
        self.imgListView.snp.makeConstraints { make in
            make.top.equalTo(self.sourceLabel.snp_bottom).offset(10)
            make.right.equalTo(contentView.snp_right).offset(-15)
            make.width.equalTo(100)
            make.height.equalTo(61.8)
        }
        
        self.lineView.backgroundColor = .background
        self.lineView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.width.equalTo(kScreenWidth - 30)
            make.bottom.equalTo(contentView.snp_bottom)
            make.height.equalTo(1)
        }
    }
    
    func configMessageNewsListCellModel (_ listModel:NewsListDataModel) {
        
        self.titleLabel.text = listModel.title.isEmpty ? "暂无数据" :listModel.title
        
        self.sourceLabel.text = listModel.source.isEmpty ? "" :listModel.source
        
        self.postTimeLabel.text = listModel.postTime.isEmpty ? "" :listModel.postTime

        self.digestLabel.text = listModel.digest.isEmpty ? "" : listModel.digest
        let imgListStr = (listModel.imgList?[0] ?? "")
        self.imgListView.kf.setImage(with: URL(string: imgListStr))
    }
    
    class func configMessageNewsListCellHeight (_ listModel:NewsListDataModel) -> CGFloat {
        
        let titleHeight = listModel.title.textAutoHeight(width: kScreenWidth - 30, font: UIFont.systemFont(ofSize: 16.0))
        
        var digestHeight = listModel.digest.textAutoHeight(width: kScreenWidth - 140, font: UIFont.systemFont(ofSize: 14.0))

        digestHeight = digestHeight < 61.8 ? 61.8 : digestHeight
        
        let cellHeight = 15 + titleHeight + 10 + 15 + 10 + digestHeight + 15
        
        return cellHeight
    }
}
