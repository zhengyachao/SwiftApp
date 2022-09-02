//
//  UITableView+Extension.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/29.
//

import Foundation
import EmptyDataSet_Swift
import SwiftyAttributes

extension UITableView {
    // MARK: 1.1、tableView 在 iOS 11 上的适配
    /// tableView 在 iOS 11 上的适配
    func tableViewNeverAdjustContentInset() {
        if #available(iOS 11, *) {
            self.estimatedRowHeight = 0
            self.estimatedSectionFooterHeight = 0
            self.estimatedSectionHeaderHeight = 0
            self.contentInsetAdjustmentBehavior = .never
        }
        
        if #available(iOS 15.0, *) {
            self.sectionHeaderTopPadding = 0
        }
    }
    
    //MARK: -- 添加空数据占位视图
    func addEmptyDataSetView() {
        let noDataStr = "暂无数据"
        self.emptyDataSetView { view in
            view.image(UIImage(named: "empty"))
                .titleLabelString(noDataStr.withTextColor(UIColor.smallFontColor).withFont(UIFont.systemFont(ofSize: 14)))
        }
    }
}
