//
//  String+Hi.swift
//  Pods
//
//  Created by 杨建祥 on 2024/11/7.
//

import SwiftUI
import HiCore
import SwifterSwift
import SwiftUIKit_Hi

public extension String {
    
    var localizedString: String {
        if profileService.value?.localization == .chinese {
            return chineseLocalizedString
        }
        return englishLocalizedString
    }

    var isValidWebUrl: Bool {
        if self.isValidHttpUrl || self.isValidHttpsUrl {
            return true
        }
        return false
    }
    
    var isValidInternalWebUrl: Bool {
        guard isValidWebUrl else { return false }
        guard self.hasPrefix(UIApplication.shared.baseWebUrl) else { return false }
        return true
    }
    
    var isValidUnivLink: Bool {
        guard isValidWebUrl else { return false }
        guard self.hasPrefix(UIApplication.shared.baseUnivLink) else { return false }
        return true
    }
    
    var isValidAppUrl: Bool { !isValidWebUrl }
    
    var isValidDeepLink: Bool {
        guard isValidAppUrl else { return false }
        return self.url?.scheme == UIApplication.shared.urlScheme
    }
    
    var routeHost: String {
        if self.isValidDeepLink {
            return self.url?.host() ?? ""
        }
        if self.isValidInternalWebUrl {
            var string = self.removingPrefix(UIApplication.shared.baseWebUrl)
            string = "\(UIApplication.shared.urlScheme)://\(string)"
            return string.url?.host() ?? ""
        }
        return ""
    }
    
    var routePath: String {
        if self.isValidDeepLink {
            guard let path = self.url?.path() else { return "" }
            return path.removingPrefix("/").removingSuffix("/")
        }
        if self.isValidInternalWebUrl {
            var string = self.removingPrefix(UIApplication.shared.baseWebUrl)
            string = "\(UIApplication.shared.urlScheme)://\(string)"
            guard let path = string.url?.path() else { return "" }
            return path.removingPrefix("/").removingSuffix("/")
        }
        return ""
    }
    
    var dictionary: [String: Any] {
        guard let data = self.data(using: .utf8) else { return [:] }
        guard let object = try? data.jsonObject() else { return [:] }
        return object as? [String: Any] ?? [:]
    }
    
}
