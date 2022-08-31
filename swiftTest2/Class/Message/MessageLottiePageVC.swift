//
//  MessageLottiePageVC.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/30.
//

import UIKit
import Lottie

class MessageLottiePageVC: YCBaseViewController {
    //gcd计时器
    var gcdTimer : DispatchSourceTimer?
    var count : Int = 60
    
    lazy var progressView: YCCircleProgressView = {
        let progressView = YCCircleProgressView()
        progressView.ratio = 0.0
        progressView.backLineWidth = 2.0
        progressView.backLineColor = .background
        progressView.progressWidth = 2.0
        progressView.progressColor = .theme
        progressView.backLineColor = .white
        
        return progressView
    }()
    
    lazy var lottieChickenView: AnimationView = {
        let lottieChickenView = AnimationView(name: "chicken")
        // 到后台时AnimationView的行为
        lottieChickenView.backgroundBehavior = .stop
        // 循环模式
        lottieChickenView.loopMode = .loop
        return lottieChickenView
    }()
    
    lazy var lottieMouseView: AnimationView = {
        let lottieMouseView = AnimationView(name: "mouse")
        // 循环模式
        lottieChickenView.loopMode = .loop
        return lottieMouseView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "定时器+Lottie动画"

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
        
        /*
        lottieChickenView.play { (isFinished) in
            self.lottieChickenView.stop()
            self.lottieChickenView.removeFromSuperview()
            self.lottieMouseView.isHidden = false
            self.lottieMouseView.play()
        }
        */
        
        view.addSubview(self.progressView)
        self.progressView.snp.makeConstraints { make in
            make.left.top.equalTo(10)
            make.width.height.equalTo(100)
        }
        
        lottieChickenView.play()
        
        createGCDTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        cancelGcdTimer()
    }
    // 创建定时器
    func createGCDTimer () {
        // 创建定时器
        self.gcdTimer = DispatchSource.makeTimerSource(flags: .strict, queue: DispatchQueue.global())
        /*
         dealine: 开始执行时间
         repeating: 重复时间间隔
         leeway: 时间精度
         */
        self.gcdTimer?.schedule(deadline: .now() + .seconds(1), repeating: .seconds(1))
        // 定时器触发 监听定时器的回调
        self.gcdTimer?.setEventHandler(handler: { [weak self] in
            // 主线程
            DispatchQueue.main.async {
                self?.count -= 1
                self?.progressView.ratio += 1/60
                self?.progressView.textLabel.text = String(self!.count) + "秒"
                self?.progressView.textLabel.font = UIFont.systemFont(ofSize: 12)
                print("times---",self?.count as Any)
                if self?.count == 0 {
                    // 取消定时器
                    self?.cancelGcdTimer()
                    // 停止动画
                    self?.lottieChickenView.stop()
                    // 隐藏圆形进度条
                    self?.progressView.isHidden = true
                }
            }
        })
        self.gcdTimer?.resume()   // 开始
        //self.gcdTimer?.suspend()// 暂停
        //self.gcdTimer?.cancel() // 取消
    }
    
    //MARK: -- 取消定时器
    func cancelGcdTimer () {
        if (self.gcdTimer != nil) {
            self.gcdTimer?.cancel()
            // 将定时器释放
            self.gcdTimer = nil
        }
    }
    // 析构过程原理（类似OC里的dealloc）
    deinit {
        print("deinit----")
        cancelGcdTimer()
    }
}
