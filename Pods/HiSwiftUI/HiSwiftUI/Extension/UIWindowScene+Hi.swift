//
//  UIWindowScene+Hi.swift
//  Pods
//
//  Created by 杨建祥 on 2024/11/12.
//

import UIKit

extension UIWindowScene {
    
    public var keyWindow: UIWindow? {
        windows.first { $0.isKeyWindow }
    }
    
}
