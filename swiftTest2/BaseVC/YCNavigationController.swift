//
//  YCNavigationController.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/17.
//

import UIKit

class YCNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 配置导航栏
        initNavBarConfig()
        self.interactivePopGestureRecognizer?.delegate = self
    }
    //MARK: 配置导航栏
    func initNavBarConfig() {

        let appearance = UIBarButtonItem.appearance()
        appearance.setBackButtonTitlePositionAdjustment(UIOffset.init(horizontal: 0.0, vertical: -60), for: .default)
        
        self.navigationBar.barTintColor = UIColor.theme
        #if swift(>=4.0)
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0)]
        #elseif swift(>=3.0)
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 18.0)];
        #endif
        self.navigationBar.tintColor = UIColor.theme
        
        let bgImage = UIImage.createImageWithColor(UIColor.theme, frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        self.navigationBar.setBackgroundImage(bgImage, for: .default)
        self.navigationBar.shadowImage = UIImage()
        
        /// 半透明度-false view.frame 从（0,64）开始计算
        self.navigationBar.isTranslucent = false
        
        // 适配ios15.0导航颜色、字体等配置
        if #available(iOS 15.0, *) {
            let app = UINavigationBarAppearance()
            // 重置背景和阴影颜色
            app.configureWithOpaqueBackground()
            app.titleTextAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
            // 设置导航栏背景色
            app.backgroundColor = UIColor.theme
            app.shadowColor = .clear
            app.backgroundEffect = nil
            UINavigationBar.appearance().scrollEdgeAppearance = app  // 带scroll滑动的页面
            UINavigationBar.appearance().standardAppearance = app // 常规页面。描述导航栏以标准高度
        }
    }
    
    //MARK: 重写self.navigationItem.leftBarButtonItem之后，自带的返回按钮就会被覆盖，右滑返回就会失效，
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.interactivePopGestureRecognizer {
            // 屏蔽调用rootViewController的滑动返回手势，避免右滑返回手势引起死机问题
            if self.viewControllers.count < 2 || self.visibleViewController == self.viewControllers.first {
                
                return false
            }
        }
        return true
    }
    
    /*
     重写 pushViewController 方法，不修改 pushViewController 的逻辑
     仅在跳转前，判断目标 VC 是否为一级页面还是二级页面，通过 viewControllers.count 来判断：
     viewControllers.count > 0，那么目标 VC 肯定是第二个页面（即二级页面）；我们就添加上 hidesBottomBarWhenPushed = true
    */
    //MARK: 详情页隐藏底部Tabbar
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }

}
