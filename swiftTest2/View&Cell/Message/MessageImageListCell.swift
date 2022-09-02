//
//  MessageImageListCell.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/9/2.
//

import UIKit

class MessageImageListCell: UITableViewCell {

    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.clipsToBounds = true
        return iconImageView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    class func cellWithTableView (_ tableView: UITableView) -> Self! {
        
        let identifier = "MessageImageListCell_Id"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            cell = MessageImageListCell.init(style: .subtitle, reuseIdentifier: identifier)
        }
        
        return cell as? Self
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setUpCellUI()
    }
    
    func setUpCellUI () {
        contentView.addSubview(self.iconImageView)
        self.iconImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }

}
