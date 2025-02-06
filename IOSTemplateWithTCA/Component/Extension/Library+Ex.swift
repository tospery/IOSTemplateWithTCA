//
//  Library+Ex.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2024/12/23.
//

import UIKit
import HiLog
import HiStats
import HiSwiftUI
import Domain

extension Library: @retroactive @preconcurrency LibraryCompatible {
    
    @MainActor
    public func mySetup() {
        self.basic()
        self.logAndStats()
    }
    
    func logAndStats() {
        logger.register(provider: SwiftyBeaverProvider())
        
        let aliyun = AliyunProvider.init()
        logger.register(provider: aliyun)
        analytics.register(provider: aliyun)
    }

}
