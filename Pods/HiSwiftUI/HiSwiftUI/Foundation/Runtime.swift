//
//  Runtime.swift
//  HiSwiftUI
//
//  Created by 杨建祥 on 2024/10/15.
//

import Foundation
import HiCore

public protocol RuntimeCompatible {
    func myWork()
}

final public class Runtime {

    public static var shared = Runtime()
    
    public init() {
    }
    
    public func work() {
        if let compatible = self as? RuntimeCompatible {
            compatible.myWork()
        } else {
            self.basic()
        }
    }
    
    public func basic() {
        ExchangeImplementations(UIViewController.self, #selector(UIViewController.present(_:animated:completion:)), #selector(UIViewController.hi_present(_:animated:completion:)))
    }
    
}

