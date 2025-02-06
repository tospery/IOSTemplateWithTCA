//
//  Bundle+Hi.swift
//  Pods
//
//  Created by 杨建祥 on 2024/12/20.
//

import Foundation
import HiCore

public extension Bundle {
    
    convenience init?(module: String) {
        self.init(identifier: "org.cocoapods." + module)
    }
    
    static var localizedBundle: Bundle? {
        if profileService.value?.localization == .english {
            return .enBundle
        }
        return .zhBundle
    }
    
}
