//
//  MessageLottiePageVC.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/30.
//

import UIKit
import Lottie

class MessageLottiePageVC: YCBaseViewController {
    
    lazy var lottieChickenView: AnimationView = {
        let lottieChickenView = AnimationView(name: "chicken")
        // 到后台时AnimationView的行为
        lottieChickenView.backgroundBehavior = .stop
        // 循环模式
        lottieChickenView.loopMode = .playOnce
        return lottieChickenView
    }()
    
    lazy var lottieMouseView: AnimationView = {
        let lottieMouseView = AnimationView(name: "mouse")
        //
        return lottieMouseView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(lottieChickenView)
        lottieChickenView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view)
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        
        lottieMouseView.isHidden = true
        view.addSubview(lottieMouseView)
        lottieMouseView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view)
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        
        lottieChickenView.play { (isFinished) in
            self.lottieChickenView.stop()
            self.lottieChickenView.removeFromSuperview()
            self.lottieMouseView.isHidden = false
            self.lottieMouseView.play()
        }
    }
}
