//
//  Untitled.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2024/10/15.
//

import Foundation
import HiCore

enum APPError: Error {
    case databaseSeedFailed
    case login(String?)
    
    var domain: String {
        "\(UIApplication.shared.bundleName)Domain"
    }
}

extension APPError: CustomNSError {
    var errorCode: Int {
        switch self {
        case .databaseSeedFailed: return 1
        case .login: return 2
        }
    }
}

extension APPError: HiErrorCompatible {
    var hiError: HiError {
        switch self {
        case let .login(message): return .app(self.domain, self.errorCode, message, nil)
        default: return .app(self.domain, self.errorCode, nil, nil)
        }
    }
}
