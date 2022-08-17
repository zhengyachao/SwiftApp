//
//  YCTabbarViewController.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/17.
//

import UIKit

class YCTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.initTabbar()
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
    }
}
