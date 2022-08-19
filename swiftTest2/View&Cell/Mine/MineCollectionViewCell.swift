//
//  MineCollectionViewCell.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/19.
//

import UIKit

class MineCollectionViewCell: UICollectionViewCell {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.white
    }
    
   
}
