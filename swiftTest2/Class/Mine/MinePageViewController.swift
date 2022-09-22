//
//  MinePageViewController.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/17.
//

import UIKit

class MinePageViewController: UIViewController {

    //MARK: collectionView
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: (kScreenWidth - 2)/3, height: kScreenWidth/3 * 0.618)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.background
        // 注册collectionCell
        collectionView.register(MineCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "MineCollectionViewCell_Id")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.background
        
        // 使用拓展UIBarButtonItem创建导航右侧按钮
        let rightItem = UIBarButtonItem.init(title: "退出", titleColor: UIColor.white, titleFont: UIFont.systemFont(ofSize: 16.0), titleEdgeInsets: UIEdgeInsets.zero, target: self, action: #selector(onClickLogoutBtn))
        self.navigationItem.rightBarButtonItem = rightItem
        
        // 添加collectionView
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        let imageView1 = UIImageView.init(frame: CGRect.zero)
        imageView1.image =  UIImage.createImageWithColor(.theme, frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        self.collectionView.addSubview(imageView1)
        imageView1.snp.makeConstraints { make in
            make.centerX.equalTo(self.collectionView)
            make.top.equalTo(kScreenWidth/3 * 0.618 * 3 + 20)
            make.width.height.equalTo(100*kHeightScale)
        }
    }
    
    @objc func onClickLogoutBtn () {
        // 退出登录通知
        kNotificationCenter.post(name:.kLogoutSuccessNotice, object: nil)
    }
}

//MARK: -- UICollectionViewDelegate, UICollectionViewDataSource
extension MinePageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifer = "MineCollectionViewCell_Id"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifer, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let webVC = YCBaseWebViewController()
        
        self.navigationController?.pushViewController(webVC, animated: true)
    }
}
