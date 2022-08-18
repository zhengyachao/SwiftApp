//
//  WindowExtension.swift

import Foundation

extension UIWindow {
    static var topWindow: UIWindow? {
        return UIApplication.shared.windows.reversed().first(where: {
            $0.screen == UIScreen.main &&
                !$0.isHidden && $0.alpha > 0
        })
    }
}
