//
//  ButtonExtension.swift

import Foundation
import UIKit

enum ButtonImageAndTitlePossitionStyle {
    case systemDefault  //图片在左，文字在右，整体居中。(系统,没有间距设置)
    case imageIsLeft    //图片在左，文字在右，整体居中
    case imageIsRight   //图片在右，文字在左，整体居中
    case imageIsTop     //图片在上，文字在下，整体居中
    case imgageIsBottom //图片在下，文字在上，整体居中
}

extension UIButton{
    /// Sets the color of the background to use for the specified state.
        ///
        /// In general, if a property is not specified for a state, the default is to use the [normal](apple-reference-documentation://hsOohbJNGp) value.
        /// If the normal value is not set, then the property defaults to a system value.
        /// Therefore, at a minimum, you should set the value for the normal state.
        /// - Author: [Dongkyu Kim](https://gist.github.com/stleamist)
        /// - Parameters:
        ///     - color: The color of the background to use for the specified state
        ///     - cornerRadius: The radius, in points, for the rounded corners on the button. The default value is 8.0.
        ///     - state: The state that uses the specified color. The possible values are described in [UIControl.State](apple-reference-documentation://hs-yI2haNm).
        ///
        func setBackgroundColor(_ color: UIColor?, cornerRadius: CGFloat = 8.0, for state: UIControl.State) {
            
            guard let color = color else {
                self.setBackgroundImage(nil, for: state)
                return
            }
            
            let length = 1 + cornerRadius * 2
            let size = CGSize(width: length, height: length)
            let rect = CGRect(origin: .zero, size: size)
            
            var backgroundImage = UIGraphicsImageRenderer(size: size).image { (context) in
                // Fill the square with the black color for later tinting.
                color.setFill()
                UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).fill()
            }
            
            backgroundImage = backgroundImage.resizableImage(withCapInsets: UIEdgeInsets(top: cornerRadius, left: cornerRadius, bottom: cornerRadius, right: cornerRadius))
            
            // Apply the `color` to the `backgroundImage` as a tint color
            // so that the `backgroundImage` can update its color automatically when the currently active traits are changed.
            if #available(iOS 13.0, *) {
                backgroundImage = backgroundImage.withTintColor(color, renderingMode: .alwaysOriginal)
            }
            
            self.setBackgroundImage(backgroundImage, for: state)
        }
}

// MARK:- 三、UIButton 图片 与 title 位置关系
/// UIButton 图片与title位置关系 https://www.jianshu.com/p/0f34c1b52604
//public extension UIButton {
//
//    /// 图片 和 title 的布局样式
//    enum ImageTitleLayout {
//        case imgTop
//        case imgBottom
//        case imgLeft
//        case imgRight
//    }
//
//    // MARK: 3.1、设置图片和 title 的位置关系(提示：title和image要在设置布局关系之前设置)
//    /// 设置图片和 title 的位置关系(提示：title和image要在设置布局关系之前设置)
//    /// - Parameters:
//    ///   - layout: 布局
//    ///   - spacing: 间距
//    /// - Returns: 返回自身
//    @discardableResult
//    func setImageTitleLayout(_ layout: ImageTitleLayout, spacing: CGFloat = 0) -> Self {
//        switch layout {
//        case .imgLeft:
//            alignHorizontal(spacing: spacing, imageFirst: true)
//        case .imgRight:
//            alignHorizontal(spacing: spacing, imageFirst: false)
//        case .imgTop:
//            alignVertical(spacing: spacing, imageTop: true)
//        case .imgBottom:
//            alignVertical(spacing: spacing, imageTop: false)
//        }
//        return self
//    }
//
//    /// 水平方向
//    /// - Parameters:
//    ///   - spacing: 间距
//    ///   - imageFirst: 图片是否优先
//    private func alignHorizontal(spacing: CGFloat, imageFirst: Bool) {
//        let edgeOffset = spacing / 2
//        imageEdgeInsets = UIEdgeInsets(top: 0,
//                                       left: -edgeOffset,
//                                       bottom: 0,
//                                       right: edgeOffset)
//        titleEdgeInsets = UIEdgeInsets(top: 0,
//                                       left: edgeOffset,
//                                       bottom: 0,
//                                       right: -edgeOffset)
//        if !imageFirst {
//            self.transform = CGAffineTransform(scaleX: -1, y: 1)
//            imageView?.transform = CGAffineTransform(scaleX: -1, y: 1)
//            titleLabel?.transform = CGAffineTransform(scaleX: -1, y: 1)
//        }
//        contentEdgeInsets = UIEdgeInsets(top: 0, left: edgeOffset, bottom: 0, right: edgeOffset)
//    }
//
//    /// 垂直方向
//    /// - Parameters:
//    ///   - spacing: 间距
//    ///   - imageTop: 图片是不是在顶部
//    private func alignVertical(spacing: CGFloat, imageTop: Bool) {
//        guard let imageSize = self.imageView?.image?.size,
//            let text = self.titleLabel?.text,
//            let font = self.titleLabel?.font
//            else {
//                return
//        }
//        let labelString = NSString(string: text)
//        let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: font])
//
//        let imageVerticalOffset = (titleSize.height + spacing) / 2
//        let titleVerticalOffset = (imageSize.height + spacing) / 2
//        let imageHorizontalOffset = (titleSize.width) / 2
//        let titleHorizontalOffset = (imageSize.width) / 2
//        let sign: CGFloat = imageTop ? 1 : -1
//
//        imageEdgeInsets = UIEdgeInsets(top: -imageVerticalOffset * sign,
//                                       left: imageHorizontalOffset,
//                                       bottom: imageVerticalOffset * sign,
//                                       right: -imageHorizontalOffset)
//        titleEdgeInsets = UIEdgeInsets(top: titleVerticalOffset * sign,
//                                       left: -titleHorizontalOffset,
//                                       bottom: -titleVerticalOffset * sign,
//                                       right: titleHorizontalOffset)
//        // increase content height to avoid clipping
//        let edgeOffset = (min(imageSize.height, titleSize.height) + spacing)/2
//        contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0, bottom: edgeOffset, right: 0)
//    }
//}

extension UIButton {
    //MARK: - 按枚举将 btn 的 image 和 title 之间位置处理
    func setupButtonImageAndTitlePossitionWith(padding: CGFloat, style: ButtonImageAndTitlePossitionStyle){
        let imageRect: CGRect = self.imageView?.frame ?? CGRect.init()
        let titleRect: CGRect = self.titleLabel?.frame ?? CGRect.init()
        let selfWidth: CGFloat = self.frame.size.width
        let selfHeight: CGFloat = self.frame.size.height
        let totalHeight = titleRect.size.height + padding + imageRect.size.height
        switch style {
        case .imageIsLeft:
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: padding / 2, bottom: 0, right: -padding / 2)
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -padding / 2, bottom: 0, right: padding / 2)
        case .imageIsRight:
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageRect.size.width + padding/2), bottom: 0, right: (imageRect.size.width + padding/2))
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: (titleRect.size.width + padding / 2), bottom: 0, right: -(titleRect.size.width +  padding/2))
        case .imageIsTop :
            self.titleEdgeInsets = UIEdgeInsets(top: ((selfHeight - totalHeight) / 2 + imageRect.size.height + padding - titleRect.origin.y), left: (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2, bottom: -((selfHeight - totalHeight) / 2 + imageRect.size.height + padding - titleRect.origin.y), right: -(selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2)
            self.imageEdgeInsets = UIEdgeInsets(top: ((selfHeight - totalHeight) / 2 - imageRect.origin.y), left: (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2), bottom: -((selfHeight - totalHeight) / 2 - imageRect.origin.y), right: -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2))
        case .imgageIsBottom:
            self.titleEdgeInsets = UIEdgeInsets(top: ((selfHeight - totalHeight) / 2 - titleRect.origin.y), left: (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2, bottom: -((selfHeight - totalHeight) / 2 - titleRect.origin.y), right: -(selfWidth/2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2)
            self.imageEdgeInsets = UIEdgeInsets(top: ((selfHeight - totalHeight) / 2 + titleRect.size.height + padding - imageRect.origin.y), left: (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2), bottom: -((selfHeight - totalHeight) / 2 + titleRect.size.height + padding - imageRect.origin.y), right: -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2))
        default:
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}
