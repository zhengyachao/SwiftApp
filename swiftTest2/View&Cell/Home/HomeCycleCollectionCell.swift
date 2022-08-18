//
//  HomeCycleCollectionCell.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/18.
//

import UIKit

class HomeCycleCollectionCell: UICollectionViewCell {
    lazy var bgImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bgImageView.contentMode = .scaleAspectFill
        contentView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
