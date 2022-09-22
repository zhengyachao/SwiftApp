//
//  MessageStackViewController.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/9/15.
//

import UIKit

class MessageStackVC: YCBaseViewController {
    
    var lineNum = 3
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        // axix属性 视图的布局方向 horizontal表示水平布局，vertical表示垂直布局。
        stackView.axis = .vertical
        // 每个arranged view之间的空隙。
        stackView.spacing = 15
        /*
         .fill （默认） 根据compression resistance和hugging两个 priority 布局
         .fillEqually 根据 等宽/高 布局
         .fillProportionally 根据intrinsic content size按比例布局
         equalSpacing 等间距布局，如果放不下，根据compression resistance压缩
         .equalCentering 等中间线间距布局，元素间距不小于 spacing 定义的值， 如果放不下，根据compression resistance压缩
         */
        stackView.distribution = .fillEqually
        stackView.alignment = .top
        
        return stackView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(self.stackView)
        
        self.stackView.snp.makeConstraints { make in
            make.top.left.equalTo(10)
            make.width.equalTo(kScreenWidth - 20)
            make.height.equalTo(200)
        }
        /*
         逻辑是一个纵向的UIStackView，
         套着多个横向的UIStackView
         可以设置行数个数来设置每行的个数
         */
        for _ in 1...3 {
            
            let hStackView = UIStackView()
            hStackView.axis = .horizontal
            hStackView.distribution = .fillEqually
            hStackView.spacing = 15
            self.stackView.addArrangedSubview(hStackView)
            hStackView.snp.makeConstraints { make in
                make.left.right.equalTo(self.stackView)
            }
            
            for index in 1...3 {
                let label = UILabel()
                label.text = "Test" + String(index)
                label.textColor = .mainFontColor
                label.backgroundColor = .white
                label.textAlignment = .center
                label.font = UIFont.systemFont(ofSize: 16)
                
                hStackView.addArrangedSubview(label)
            }
        }
    }
}
