//
//  HomePageViewController.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/17.
//

import UIKit
import Kingfisher
import SwiftyJSON
import HandyJSON

class HomePageViewController: UIViewController {
    
    var countNum = 0
    
    let imageArray = ["http://mvimg2.meitudata.com/55fe3d94efbc12843.jpg",
                      "http://mvimg2.meitudata.com/55fe3d94efbc12843.jpg",
                      "http://mvimg2.meitudata.com/55fe3d94efbc12843.jpg",
                      "http://mvimg2.meitudata.com/55fe3d94efbc12843.jpg",
                      "http://mvimg2.meitudata.com/55fe3d94efbc12843.jpg",
                      "http://mvimg2.meitudata.com/55fe3d94efbc12843.jpg",
                      "http://mvimg2.meitudata.com/55fe3d94efbc12843.jpg",
                      "http://mvimg2.meitudata.com/55fe3d94efbc12843.jpg",
                      "http://mvimg2.meitudata.com/55fe3d94efbc12843.jpg"]
    
    //MARK: 懒加载--轮播图ZCycleView
    lazy var topCycleView: ZCycleView = {
        
        let cycleView = ZCycleView()
        cycleView.delegate = self
        /// 刷新数据
        cycleView.reloadItemsCount(imageArray.count)
        // 初始下标
        cycleView.initialIndex = 0
        /// 滚动时间间隔，默认3s
        cycleView.timeInterval = 2
        /// 是否自动滚动
        cycleView.isAutomatic = false
        /// 是否无限轮播
        cycleView.isInfinite = false
        /// 中间item的放大比例, >=1
        cycleView.itemZoomScale = 1.5
        cycleView.itemSpacing = 10
        /// item 间距
        cycleView.itemSize = CGSize(width: kScreenWidth - 200, height: (kScreenWidth - 200) * 0.618)
        return cycleView
    }()
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: kScreenWidth - 60, height: kScreenHeight - kAppNavAndTabBarHeight - 200 - 20)
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.init(top: 10, left: 30, bottom: 10, right: 30)
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        // 不展示滚动条
        collectionView.showsHorizontalScrollIndicator = false
        // 注册collectionCell
        collectionView.register(HomeCycleCollectionCell.classForCoder(), forCellWithReuseIdentifier: "HomeCycleCollectionCell_Id")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.background
        
        // 使用拓展UIBarButtonItem创建导航右侧按钮
        let rightItem = UIBarButtonItem.init(title: "设置", titleColor: UIColor.white, titleFont: UIFont.systemFont(ofSize: 16.0), titleEdgeInsets: UIEdgeInsets.zero, target: self, action: #selector(onClickSettingBtn))
        self.navigationItem.rightBarButtonItem = rightItem

//        view.addSubview(topCycleView)
//        view.addSubview(collectionView)
//        topCycleView.snp.makeConstraints { make in
//            make.top.left.right.equalTo(view)
//            make.height.equalTo(200)
//        }
//        
//        collectionView.snp.makeConstraints { make in
//            make.top.equalTo(topCycleView.snp_bottom).offset(10)
//            make.left.right.equalTo(view)
//            make.bottom.equalTo(view.snp_bottom).offset(-10)
//        }
        
        
        requestDownloadApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.countNum = 0
        
//        self.navigationController?.navigationBar.isHidden = true
//        requestAppListApi()
//        requestDownloadApi()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: -- 跳转到手势密码页面
    @objc func onClickSettingBtn () {
        let lockVC = YCPatternLockVC()
        
        self.navigationController?.pushViewController(lockVC, animated: true)
    }
    
    //MARK: 网络请求---download
    func requestDownloadApi () {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = .annularDeterminate
        
        homeProvider.request(HomeAppListApi.downloadTestApi, callbackQueue: nil) { progress in
            print(progress.progress)
    
            hud.progress = Float(progress.progress)
        } completion: { result in
            
            self.countNum += 1
            
            switch result {
                
            case let .success(response):
                let jsonStr = JSON(response.data).description
                print(jsonStr)
                hud.hide(animated: true)
                
            case let .failure(error as NSError):
                print(error)
            }
            
            /* 轮询
            // 初始化延时任务
            let dispatchWorkItem = DispatchWorkItem {[weak self] in
                self?.requestDownloadApi()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: dispatchWorkItem)
            
            if self.countNum == 3 {
                print("111111111---",self.countNum)
                dispatchWorkItem.cancel()
            }
            */
        }
    }
    
    //MARK: 网络请求---test1
    func requestAppListApi () {
        homeProvider.request(HomeAppListApi.findRecruitmentDataPage(majorId: 1357)) { result in
            switch result {
            case let .success(response):
                /*
                 返回值格式
                 {
                     "rescode": "200",
                     "resMessage": "成功",
                     "data": {
                         "relationMajorType": 2
                     }
                 }
                 */
                // SwiftyJSON  Data转JSON字符串:
                let jsonStr = JSON(response.data).description
                print("JSON字符串---",jsonStr)
                // HandyJSON JSON字符串转model
                let homeTestModel = HomeTestModel.deserialize(from: jsonStr)
                print(homeTestModel?.data?.relationMajorType as Any)
                
                // 那么，我们指定解析 "data"，通过点来表达路径---定点解析
                let forecastModel = ForecastModel.deserialize(from: jsonStr, designatedPath: "data")
                print("forecastModel------",forecastModel?.relationMajorType as Any)
                
            case let .failure(error as NSError):
                print(error)
            }
        }
    }
}

//MARK: -- ZCycleViewProtocol
extension HomePageViewController :ZCycleViewProtocol {
    /// 注册cell，[重用标志符：cell类]
    func cycleViewRegisterCellClasses() -> [String : AnyClass] {
        
        return ["HomeCycleCollectionCell": HomeCycleCollectionCell.self]
    }
    
    /// cell赋值
    func cycleViewConfigureCell(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, realIndex: Int) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCycleCollectionCell", for: indexPath) as! HomeCycleCollectionCell
        
        cell.bgImageView.kf.setImage(with: URL(string: imageArray[realIndex]))
//        cell.bgImageView.layer.cornerRadius = 20.0
//        cell.bgImageView.clipsToBounds = true
        
        return cell
    }
    
    /// 点击了index
    func cycleViewDidSelectedIndex(_ cycleView: ZCycleView, index: Int) {
        
        print("点击了----index",index)
    }
    
    /// pageControl
    func cycleViewConfigurePageControl(_ cycleView: ZCycleView, pageControl: ZPageControl) {
        
        pageControl.isHidden = false
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.pageIndicatorTintColor = .green
        pageControl.frame = CGRect(x: 0, y: cycleView.bounds.height-25, width: cycleView.bounds.width, height: 25)
    }
}

extension HomePageViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCycleCollectionCell_Id", for: indexPath) as! HomeCycleCollectionCell
        
        cell.bgImageView.kf.setImage(with: URL(string: imageArray[indexPath.item]))
//        cell.bgImageView.image = UIImage.createImageWithColor(UIColor.random, frame: cell.bounds)
        cell.bgImageView.layer.cornerRadius = 30.0
        cell.bgImageView.clipsToBounds = true
        
        return cell
    }
}
