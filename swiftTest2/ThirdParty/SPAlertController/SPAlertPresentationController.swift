//
//  SPAlertPresentationController.swift
//  Swift_SPAlertController
//
//  Created by lidongxi on 2019/12/6.
//  Copyright © 2019 lidongxi. All rights reserved.
//

import UIKit

// UIPresentationController控制控制器跳转的类,是iOS8新增的一个API，用来控制 controller之间的跳转特效，
// 例如：显示一个模态窗口，大小和位置是自定义的，遮罩在原来的页面
class SPAlertPresentationController: UIPresentationController {
    
    /// 自定义背景蒙版
    var customOverlayView: UIView?
    convenience init(customOverlay: UIView?, presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        self.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.customOverlayView = customOverlay
    }
    
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        if let containerV = self.containerView {
            self.overlayView.frame = containerV.bounds
            //self.customOverlayView?.frame = containerV.bounds
        }
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
    }
    
    // MARK: - 1.将要开始弹出
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        let alertController = self.presentedViewController as! SPAlertController
        if customOverlayView == nil {
            (overlayView as! SPOverlayView).setAppearanceStyle(appearanceStyle: alertController.backgroundViewAppearanceStyle, alpha: alertController.backgroundViewAlpha)
        }
        
        // 遮罩的alpha值从0～1变化，UIViewControllerTransitionCoordinator协是一个过渡协调器，当执行模态过渡或push过渡时，可以对视图中的其他部分做动画
        let coordinator = self.presentedViewController.transitionCoordinator
        if let coordinatorT = coordinator {
            coordinatorT.animate(alongsideTransition: { (context) in
                self.overlayView.alpha = 1.0
            }, completion: nil)
        } else {
            self.overlayView.alpha = 1.0
        }
        alertController.delegate?.willPresentAlertController(alertController: alertController)
        
    }
    // MARK: - 2.已经弹出
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        
        let alertController = self.presentedViewController as! SPAlertController
        alertController.delegate?.didPresentAlertController(alertController: alertController)
    }
    
    // MARK: - 3.即将dismiss
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        let alertController = self.presentedViewController as! SPAlertController
        // 遮罩的alpha值从1～0变化，UIViewControllerTransitionCoordinator协议执行动画可以保证和转场动画同步
        let coordinator = self.presentedViewController.transitionCoordinator
        if let coordinatorT = coordinator {
            coordinatorT.animate(alongsideTransition: { (context) in
                self.overlayView.alpha = 0.0
            }, completion: nil)
        } else {
            self.overlayView.alpha = 0.0
        }
        alertController.delegate?.willDismissAlertController(alertController: alertController)
    }
    // MARK: - 4.已经dismissed
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        
        if completed {
            self.overlayView.removeFromSuperview()
        }
        let alertController = self.presentedViewController as! SPAlertController
        alertController.delegate?.didDismissAlertController(alertController: alertController)
    }
    
  
    override var frameOfPresentedViewInContainerView: CGRect{
        return self.presentedView!.frame
    }
    
//    private lazy var overlayView: CustomOverlayView = {
//        let overlay = CustomOverlayView.init()
//        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapOverlayView))
//        overlay.addGestureRecognizer(tap)
//        self.containerView?.insertSubview(overlay, at: 0)
//       // self.containerView?.addSubview(overlay)
//        return overlay
//    }()
    var _overlayView: UIView?
    private var overlayView: UIView {
        if _overlayView == nil {
            if let customView = customOverlayView {
                _overlayView = customView
            } else {
                _overlayView = SPOverlayView.init()
            }
            _overlayView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapOverlayView))
            _overlayView!.addGestureRecognizer(tap)
            self.containerView?.insertSubview(_overlayView!, at: 0)
        }
        return _overlayView!
    }
    
//    lazy var overlayView: SPOverlayView = {
//        let overlay = SPOverlayView.init()
//        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapOverlayView))
//        overlay.addGestureRecognizer(tap)
//        self.containerView?.addSubview(overlay)
//        return overlay
//    }()

    
    @objc func tapOverlayView() {
        let alertController = self.presentedViewController as! SPAlertController
        if alertController.tapBackgroundViewDismiss {
            alertController.dismiss(animated: true, completion: nil)
        }
    }
}
