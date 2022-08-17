//
//  YCNavigationController.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/17.
//

import UIKit

class YCNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self .initNavBarConfig()
    }
    // 配置导航栏
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
        
        let bgImage = self.createImageWithColor(UIColor.theme, frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        self.navigationBar.setBackgroundImage(bgImage, for: .default)
        self.navigationBar.shadowImage = UIImage()
        
        self.navigationBar.isTranslucent = false
        
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
    
    //生成一个指定颜色的图片
    func createImageWithColor(_ color: UIColor, frame: CGRect) -> UIImage? {
        // 开始绘图
        UIGraphicsBeginImageContext(frame.size)
        
        // 获取绘图上下文
        let context = UIGraphicsGetCurrentContext()
        // 设置填充颜色
        context?.setFillColor(color.cgColor)
        // 使用填充颜色填充区域
        context?.fill(frame)
        
        // 获取绘制的图像
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        // 结束绘图
        UIGraphicsEndImageContext()
        return image
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
