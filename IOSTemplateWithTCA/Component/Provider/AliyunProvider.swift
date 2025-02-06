//
//  AliyunProvider.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2024/12/23.
//

import Foundation
import HiSwiftUI
import HiBase
import HiLog
import HiStats

final class AliyunProvider: HiLog.ProviderType, HiStats.ProviderType {
    
    init() {
    }
    
    // swiftlint:disable function_parameter_count
    func log(
        _ message: @autoclosure () -> Any,
        module: String,
        level: Level,
        file: String,
        line: Int,
        function: String,
        context: Any?
    ) {
    }
    // swiftlint:enable function_parameter_count

    func stats(_ eventName: String, parameters: [String: Any]?) {
    }
    
}
