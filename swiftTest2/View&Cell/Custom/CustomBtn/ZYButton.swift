//
//  ZYButton.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/9/28.
//

import UIKit

class ZYButton: UIButton {
 
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        var bounds = self.bounds
        // 若原热区小于44x44，则放大热区，否则保持原大小不变
        let widthDelta = max(44 - bounds.size.width, 0)
        let heightDelta = max(44 - bounds.size.height, 0)
        // CGRectInset(CGRect rect, CGFloat dx, CGFloat dy) 即如果dx、dy为正，则移动后缩小；若为负，则移动后扩大
        bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta)
        
        // 判断点击的点是否在某一区域内
        let isContain = CGRectContainsPoint(bounds, point)
        
        return isContain
    }

}
