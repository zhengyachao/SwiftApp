//
//  MessageNewsDetailVC.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/30.
//

import UIKit
import SwiftyJSON
import HandyJSON
import WebKit

class MessageNewsDetailVC: YCBaseViewController {
    var newsId = String()
    var detailModel = NewsDetailModel()
    
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.uiDelegate = self
        webView.navigationDelegate = self
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "新闻详情"
        
        view.addSubview(self.webView)
        self.webView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        // 根据新闻id获取新闻详情Api
        requestNewsDetailApi()
    }
    
    
    //MARK: --  加载webView内容--parameter model: 新闻模型
    func loadWebViewContent(model: NewsDetailDataModel) {
        
        // &nbsp 空格占位符
        var html = ""
        html += "<div class=\"title\" style='font-size:40px; color:#333333;font-weight:bold; margin:10px 10px;display: -webkit-box;-webkit-line-clamp:2;overflow: hidden;text-overflow: ellipsis;-webkit-box-orient: vertical;'>\(model.title)</div>"
        html += "<div class=\"time\">\(model.source)&nbsp;&nbsp;&nbsp;&nbsp;\(model.ptime)</div>"
        
        // 临时正文 - 这样做的目的是不修改模型
        var tempNewstext = model.content
        
        // 有图片才去拼接图片
        if model.images!.count > 0 {
            // 拼接图片标签
            for (index, imageModel) in model.images!.enumerated() {
                // 图片占位符范围
                // 获取图片占位符的范围 即类似<!--IMG#0--> 在model.newstext的位置
                let range = tempNewstext.range(of: imageModel.position)
                
                // 默认宽、高为0
                var width: CGFloat = 0
                var height: CGFloat = 0
                
                let pixel: Array = (imageModel.size.components(separatedBy: "*"))

                if pixel.count != 2 {
                    continue
                }
                width  = CGFloat(pixel[0].toDouble()!)
                height = CGFloat(pixel[1].toDouble()!)
    
                // 如果图片超过了最大宽度，才等比压缩 这个最大宽度是根据css里的container容器宽度来自适应的
                if width >= kScreenWidth - 40 {
                    let rate = (kScreenWidth - 40) / width
                    width = width * rate
                    height = height * rate
                }
                
                // 图片URL
                let imgUrl = imageModel.imgSrc
                
                // 在img标签中添加一个id并赋值图片的url，用于标识图片，这个id用作唯一标识符
                // 最终会替换掉img标签的对应src值，传递下载完成后的图片路径
                // 给图片添加onclick方法 - didTappedImage
                let imgTag = "<img onclick='didTappedImage(\(index), \"\(imgUrl)\");' src='\(imgUrl)' id='\(imgUrl)' width='\(width)' height='\(height)' />"

                // 使用带loading占位图的img标签，替换掉类似<!--IMG#0-->原有标识符
                tempNewstext = tempNewstext.replacingOccurrences(of: imageModel.position, with: imgTag, options: .caseInsensitive, range: range)
            }
        }
        
        html += "<div id=\"content\">\(tempNewstext)</div>"
        // 加载
        webView.loadHTMLString(html, baseURL: nil)
    }
    
    //MARK: --根据新闻id获取新闻详情Api
    func requestNewsDetailApi () {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        messageProvider.request(MessagePageApi.getNewsDetails(newsId: self.newsId)) { result in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            switch result {
            case let .success(response):
                
                let jsonStr = JSON(response.data).description
                print("JSON字符串---",jsonStr)
                self.detailModel = NewsDetailModel.deserialize(from: jsonStr) ?? NewsDetailModel()
                
                // 加载webView内容
                if self.detailModel.code == 1 {
                    self.loadWebViewContent(model: self.detailModel.data!)
                }
            case let .failure(error as NSError):
                print(error)
            }
        }
    }
}

extension MessageNewsDetailVC: WKUIDelegate,WKNavigationDelegate {
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("1.页面开始加载")
    }
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("2.当内容开始返回")
    }
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("3.页面加载完成")
        // 图片缩放比例不正确问题
        webView.evaluateJavaScript("""
        var imgs = document.getElementsByTagName("img")
        for (var i = 0; i < imgs.length; i++) {
            imgs[i].setAttribute('width', '100%')
            imgs[i].setAttribute('height', 'auto')
        }
        """,completionHandler: nil)

    }
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("4.页面加载失败")
    }
    // 接收到服务器跳转请求之后调用
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("接收到服务器跳转请求")
    }
    // 在收到响应后，决定是否跳转 -> 默认允许
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        //允许跳转
        decisionHandler(.allow)
        //不允许跳转
        //decisionHandler(.cancel)
    }
}
