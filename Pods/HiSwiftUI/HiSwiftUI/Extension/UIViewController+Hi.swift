//
//  UIViewController+Hi.swift
//  Pods
//
//  Created by 杨建祥 on 2024/11/11.
//

import UIKit

extension UIViewController {
    
    struct RuntimeKey {
        static let automaticallySetModalPresentationStyleKey = UnsafeRawPointer.init(bitPattern: "automaticallySetModalPresentationStyleKey".hashValue)
    }
    
    var automaticallySetModalPresentationStyle: Bool? {
        get {
            objc_getAssociatedObject(self, RuntimeKey.automaticallySetModalPresentationStyleKey!) as? Bool
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.automaticallySetModalPresentationStyleKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    @objc func hi_present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if #available(iOS 13.0, *) {
            var need = true
            if let _ = self as? UIImagePickerController {
                need = false
            } else if let _ = self as? UIAlertController {
                need = false
            } else {
                let className = viewControllerToPresent.className
                if className == "PopupDialog" ||
                    className == "SideMenuNavigationController" {
                    need = false
                }
            }
            if need {
                if let auto = self.automaticallySetModalPresentationStyle, auto == false {
                    need = false
                }
            }
            if need {
                viewControllerToPresent.modalPresentationStyle = .fullScreen
            }
        }
        self.hi_present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    private class var sharedApplication: UIApplication? {
        let selector = NSSelectorFromString("sharedApplication")
        return UIApplication.perform(selector)?.takeUnretainedValue() as? UIApplication
    }

    /// Returns the current application's top most view controller.
    public class var topMost: UIViewController? {
        guard let currentWindows = self.sharedApplication?.windows else { return nil }
        var rootViewController: UIViewController?
        for window in currentWindows {
            if let windowRootViewController = window.rootViewController, window.isKeyWindow {
                rootViewController = windowRootViewController
                break
            }
        }
        
        return self.topMost(of: rootViewController)
    }

    /// Returns the top most view controller from given view controller's stack.
    public class func topMost(of viewController: UIViewController?) -> UIViewController? {
        // presented view controller
        if let presentedViewController = viewController?.presentedViewController {
            return self.topMost(of: presentedViewController)
        }
        
        // UITabBarController
        if let tabBarController = viewController as? UITabBarController,
           let selectedViewController = tabBarController.selectedViewController {
            return self.topMost(of: selectedViewController)
        }
        
        // UINavigationController
        if let navigationController = viewController as? UINavigationController,
           let visibleViewController = navigationController.visibleViewController {
            return self.topMost(of: visibleViewController)
        }
        
        // UIPageController
        if let pageViewController = viewController as? UIPageViewController,
           pageViewController.viewControllers?.count == 1 {
            return self.topMost(of: pageViewController.viewControllers?.first)
        }
        
        // child view controller
        for subview in viewController?.view?.subviews ?? [] {
            if let childViewController = subview.next as? UIViewController {
                return self.topMost(of: childViewController)
            }
        }
        
        return viewController
    }
}
