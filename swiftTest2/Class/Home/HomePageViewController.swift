//
//  HomePageViewController.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/17.
//

import UIKit
import Kingfisher

class HomePageViewController: UIViewController, ZCycleViewProtocol, UICollectionViewDelegate {
    
    let imageArray = ["http://mvimg2.meitudata.com/55fe3d94efbc12843.jpg",
                      "http://mvimg2.meitudata.com/55fe3d94efbc12843.jpg",
                      "http://mvimg2.meitudata.com/55fe3d94efbc12843.jpg"]
    //MARK: 懒加载
    lazy var topCycleView: ZCycleView = {
        
        let cycleView = ZCycleView()
        cycleView.delegate = self
        /// 刷新数据
        cycleView.reloadItemsCount(imageArray.count)
        
        // 初始下标
        cycleView.initialIndex = 1
        /// 滚动时间间隔，默认3s
        cycleView.timeInterval = 2
        /// 是否自动滚动
        cycleView.isAutomatic = false
        /// 中间item的放大比例, >=1
        cycleView.itemZoomScale = 1.5
        cycleView.itemSpacing = 10
        /// item 间距
        cycleView.itemSize = CGSize(width: kScreenWidth - 200, height: (kScreenWidth - 200) * 0.618)
        return cycleView
    }()
    
    lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView()
        
        collectionView.delegate = self
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.background
        
        view.addSubview(topCycleView)
        topCycleView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view)
            make.height.equalTo(200)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: ZCycleViewProtocol
    func cycleViewRegisterCellClasses() -> [String : AnyClass] {
        /// 注册cell，[重用标志符：cell类]
        
        return ["HomeCycleCollectionCell": HomeCycleCollectionCell.self]
    }
    
    func cycleViewConfigureCell(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, realIndex: Int) -> UICollectionViewCell {
        /// cell赋值
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCycleCollectionCell", for: indexPath) as! HomeCycleCollectionCell
        
        cell.bgImageView.kf.setImage(with: URL(string: imageArray[realIndex]))

        return cell
    }
    
    
    func cycleViewDidSelectedIndex(_ cycleView: ZCycleView, index: Int) {
        /// 点击了index
        print("点击了----index",index)
    }
    
    func cycleViewConfigurePageControl(_ cycleView: ZCycleView, pageControl: ZPageControl) {
        /// pageControl
        pageControl.isHidden = false
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.pageIndicatorTintColor = .green
        pageControl.frame = CGRect(x: 0, y: cycleView.bounds.height-25, width: cycleView.bounds.width, height: 25)
    }
    
}
