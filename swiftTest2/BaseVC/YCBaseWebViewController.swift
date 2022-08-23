//
//  YCBaseWebViewController.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/22.
//

import UIKit
import WebKit

class YCBaseWebViewController: YCBaseViewController {

    lazy var wkwebView: WKWebView = {
        
        let webview = WKWebView.init(frame: self.view.bounds)
        webview.uiDelegate = self
        webview.navigationDelegate = self
        return webview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "WKWebView"
        // Do any additional setup after loading the view.
        
        initWkwebviewUI()
    }
    
    func initWkwebviewUI() {
        view.addSubview(wkwebView)
        
        wkwebView.load(NSURLRequest.init(url: NSURL.init(string: "https://www.baidu.com")! as URL) as URLRequest)
    }
}

// MARK: - WKNavigationDelegate, WKUIDelegate
extension YCBaseWebViewController : WKNavigationDelegate, WKUIDelegate {
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
    // 在发送请求之前，决定是否跳转 -> 默认允许
    @available(iOS 13.0, *)
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
        decisionHandler(.allow, preferences)
    }
}
