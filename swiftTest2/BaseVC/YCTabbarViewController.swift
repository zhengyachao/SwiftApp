//
//  YCTabbarViewController.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/17.
//

import UIKit
import ESTabBarController_swift

class YCTabbarViewController: ESTabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 初始化Tabbar
//        initTabbar()
        
        initCustomESTabbar()
    }
    
    func initCustomESTabbar() {
        
        let v1 = HomePageViewController()
        let v2 = MessagePageViewController()
        let v3 = MinePageViewController()
        
        let v1NavVC = YCNavigationController.init(rootViewController: v1)
        let v2NavVC = YCNavigationController.init(rootViewController: v2)
        let v3NavVC = YCNavigationController.init(rootViewController: v3)

        v1NavVC.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(),title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        v2NavVC.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(),title: "Message", image: UIImage(named: "message"), selectedImage: UIImage(named: "message_1"))
        v3NavVC.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(),title: "Me", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
        
        v1.title    = "Home"
        v2.title    = "Message"
        v3.title    = "Me"
        
        self.viewControllers = [v1NavVC, v2NavVC, v3NavVC]

        self.selectedIndex = 0
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // 确保当前显示的是首页界面,本例中首页是第一个 tabBar
            if self.selectedViewController == self.viewControllers?[1] {
                // 再次选中的 tab 页面是之前上一次选中的控制器页面
                if viewController == self.selectedViewController {
                    // 发送通知,让首页刷新数据
                    kNotificationCenter.post(name: .kRefreshMessageListNotice, object: nil)
                    return false;
                }
         
            }

        return true
    }
    
    func initTabbar () {
        
        let homeVC    = HomePageViewController()
        let messageVC = MessagePageViewController()
        let mineVC    = MinePageViewController()
        
        let homeNavVC = YCNavigationController.init(rootViewController: homeVC)
        let msgNavVC  = YCNavigationController.init(rootViewController: messageVC)
        let mineNavVC = YCNavigationController.init(rootViewController: mineVC)
        
        homeNavVC.tabBarItem    = UITabBarItem.init(title: "", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        msgNavVC.tabBarItem     = UITabBarItem.init(title: "", image: UIImage(named: "message"), selectedImage: UIImage(named: "message_1"))
        mineNavVC.tabBarItem    = UITabBarItem.init(title: "", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
        
        homeVC.title    = "首页"
        messageVC.title = "Message"
        mineVC.title    = "Mine"
        
        self.tabBar.isTranslucent = false
        self.tabBar.shadowImage = UIImage()
        
        self.viewControllers = [homeNavVC, msgNavVC, mineNavVC]
        
        //默认选中的下标
        self.selectedIndex = 0
    }
}
