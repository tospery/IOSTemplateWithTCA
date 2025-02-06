//
//  AppEvent.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2024/12/23.
//

import Foundation
import HiStats
import SwifterSwift
import HiCore
import HiBase
import HiSwiftUI

let analytics = Analytics<AppEvent>()

func stats(_ event: AppEvent) {
    analytics.stats(event)
}

enum AppEvent {
    case beginPageView(name: String)
    case endPageView(name: String)
}

extension AppEvent: HiStats.EventType {
    
    func name(for provider: HiStats.ProviderType) -> String? {
        switch self {
        case .beginPageView: return "begin_page_view"
        case .endPageView: return "end_page_view"
        }
    }
    
    func parameters(for provider: HiStats.ProviderType) -> [String: Any]? {
        var parameters = environment
        parameters += profileService.value?.toJSON() ?? [:]
        switch self {
        case let .beginPageView(name),
            let .endPageView(name):
            parameters[Parameter.name] = name
        }
        return parameters
    }
    
}
