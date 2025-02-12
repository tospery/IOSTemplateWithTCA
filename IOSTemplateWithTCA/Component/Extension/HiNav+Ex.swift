//
//  HiNav+Ex.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2024/11/14.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import SwifterSwift
import HiBase
import HiCore
import HiNav
import HiSwiftUI
import HiLog
import Domain

@Reducer(state: .equatable)
enum Push {
    case about(AboutReducer)
    case web(WebReducer)
    
    @ViewBuilder
    static func destination(_ store: Store<Push.State, Push.Action>) -> some View {
        switch store.case {
        case let .about(store): AboutScreen(store: store)
        case let .web(store): WebScreen(store: store)
        }
    }
}

extension HiNavHost {
    
    static var root: HiNavHost { "root" }
    static var dashboard: HiNavHost { "dashboard" }
    static var favorite: HiNavHost { "favorite" }
    static var personal: HiNavHost { "personal" }
    
    static var about: HiNavHost { TileId.about.rawValue.lowercased() }
}

extension HiNavPath { }


extension HiNav: @retroactive HiNavCompatible {
    
    public func isLegalHost(host: HiNavHost) -> Bool {
        true
    }
    
    public func allowedPaths(host: HiNavHost) -> [HiNavPath] {
        []
    }
    
    public func isLogined() -> Bool {
        profileService.value?.loginedUser?.isValid ?? false
    }
    
    public func needLogin(host: HiNavHost, path: HiNavPath?) -> Bool {
        switch host {
        case .favorite: return true
        default: return false
        }
    }
    
    public func resolution(_ target: String) -> Any? {
        log("target: \(target)")
        if target.isValidWebUrl {
            if target.isValidUnivLink {
                return nil
            }
            
            let params = target.url?.queryParameters ?? [:]
            var url = target.url?.deletingAllQueryParameters()
            if params.count != 0 {
                url = url?.myAppendingQueryParameters(params)
            }
            let urlString = url?.absoluteString ?? ""
            
            guard urlString.isValidInternalWebUrl else {
                return IOSTemplateWithTCA.Push.State.web(.init(url: self.deepLink(host: .web, parameters: [
                    Parameter.url: urlString
                ])))
            }
            var native = ""
            var paths = urlString.url?.pathComponents ?? []
            paths.removeAll("/")
            
            // 此处，用于将Web URL转换为Native URL的处理
            
            if native.isNotEmpty {
                native = native.url?.myAppendingQueryParameters([Parameter.fromWeb: true.string]).absoluteString ?? ""
                return self.handleDeepLink(native)
            }
            return IOSTemplateWithTCA.Push.State.web(.init(url: self.deepLink(host: .web, parameters: [
                Parameter.url: urlString
            ])))
        } else {
            guard target.isValidDeepLink else {
                return target
            }
            return self.handleDeepLink(target)
        }
    }
    
    // swiftlint:disable function_body_length
    func handleDeepLink(_ target: String) -> Any? {
        guard target.isValidDeepLink else { return nil }
        guard let url = target.url else { return nil }
        if target.isValidBackUrl {
            let type = url.queryParameters?.enum(for: Parameter.type, type: BackType.self) ?? .auto
            return BackState(type: type)
        }
        
        guard let host = url.host()?.lowercased() else { return nil }
        var forwardType = url.queryParameters?.enum(for: Parameter.forwardType, type: ForwardType.self)
        if forwardType == nil {
            if host == .login {
                forwardType = .present
            } else if target.isValidOpenUrl {
                forwardType = .open
            } else {
                forwardType = .push
            }
        }
        switch forwardType! {
        case .push:
            if host == .about { return IOSTemplateWithTCA.Push.State.about(.init(url: target)) }
            if host == .web { return IOSTemplateWithTCA.Push.State.web(.init(url: target)) }
        case .present:
            if host == .login { return LoginReducer.State.init(url: target) }
        case .open:
            if target.isValidToastUrl {
                let message = url.queryParameters?.string(for: Parameter.message) ?? ""
                let active = url.queryParameters?.bool(for: Parameter.active)
                return ToastState.init(message: message, active: active)
            } else if target.isValidAlertUrl {
                let title = url.queryParameters?.string(for: Parameter.title) ?? ""
                let message = url.queryParameters?.string(for: Parameter.message) ?? ""
                var state = AlertState<ITAlertAction>.init {
                    TextState(title)
                } message: {
                    TextState(message)
                }
                let jsonString = url.queryParameters?.string(for: Parameter.actions) ?? ""
                let jsonObject = try? jsonString.data(using: .utf8)?.jsonObject()
                let myActions = jsonObject as? [String] ?? []
                state.buttons = myActions
                    .compactMap { ITAlertAction(string: $0) }
                    .map { action in
                        ButtonState<ITAlertAction>.init(
                            role: action.role,
                            action: action,
                            label: {
                                TextState(action.description)
                            }
                        )
                    }
                return state
            } else if target.isValidSheetUrl {
                let title = url.queryParameters?.string(for: Parameter.title) ?? ""
                let message = url.queryParameters?.string(for: Parameter.message) ?? ""
                var state = ConfirmationDialogState<ITAlertAction>.init {
                    TextState(title)
                } message: {
                    TextState(message)
                }
                let jsonString = url.queryParameters?.string(for: Parameter.actions) ?? ""
                let jsonObject = try? jsonString.data(using: .utf8)?.jsonObject()
                let myActions = jsonObject as? [String] ?? []
                state.buttons = myActions
                    .compactMap { ITAlertAction(string: $0) }
                    .map { action in
                        ButtonState<ITAlertAction>.init(
                            role: action.role,
                            action: action,
                            label: {
                                TextState(action.description)
                            }
                        )
                    }
                return state
            } else if target.isValidPopupUrl {
                let type = url.queryParameters?.string(for: Parameter.type) ?? ""
                let data = url.queryParameters?.string(for: Parameter.data)
                return PopupState.init(type: type, data: data)
            } else if target.isValidLogicUrl {
                guard let value = url.queryParameters?.string(for: Parameter.type) else { return nil }
                guard let type = LogicType(rawValue: value) else { return nil }
                return handleLogic(type, url.queryParameters?.string(for: Parameter.data) ?? "")
            }
        }
        return nil
    }
    // swiftlint:enable function_body_length
    
    func handleLogic(_ type: LogicType, _ data: String) -> Any? {
        log("业务类型：\(type)")
        log("业务数据：\(data)")
        return nil
    }

}
