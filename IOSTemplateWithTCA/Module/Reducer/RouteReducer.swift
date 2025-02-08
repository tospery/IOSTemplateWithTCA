//
//  AppRoute.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2024/10/6.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import DependenciesAdditions
import HiBase
import HiCore
import HiNav
import HiSwiftUI
import Domain
import HiLog

@Reducer
struct RouteReducer {
    
    @ObservableState
    struct State: Equatable {
        @Shared(.profile) var profile = .default
        @Presents var login: LoginReducer.State?
        @Presents var alert: AlertState<ITAlertAction>?
        @Presents var sheet: ConfirmationDialogState<ITAlertAction>?
        var popup: PopupState?
        var push = StackState<IOSTemplateWithTCA.Push.State>()
        var isActivating = false
        var showToast = false
        var toastMessage: String?
        var redirection: String?
        var data: Any?
    
        static func == (lhs: State, rhs: State) -> Bool {
            lhs.profile == rhs.profile
            && lhs.login == rhs.login
            && lhs.alert == rhs.alert
            && lhs.sheet == rhs.sheet
            && lhs.popup == rhs.popup
            && lhs.push == rhs.push
            && lhs.isActivating == rhs.isActivating
            && lhs.showToast == rhs.showToast
            && lhs.toastMessage == rhs.toastMessage
            && lhs.redirection == rhs.redirection
            && compareAny(lhs.data, rhs.data)
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case login(PresentationAction<LoginReducer.Action>)
        case alert(PresentationAction<ITAlertAction>)
        case sheet(PresentationAction<ITAlertAction>)
        case popup(PopupState?)
        case push(StackActionOf<IOSTemplateWithTCA.Push>)
        case toastMessage(String)
        case target(String)
    }
    
    @Dependency(\.application) var application
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case let .toastMessage(message):
                state.toastMessage = message
                state.isActivating = false
                state.showToast = true
                return .none
            case .sheet(.presented(.exit)):
                log("退出了Sheet框")
                return .none
            case .alert(.presented(.default)):
                log("确认了Alert框")
                return .none
            case let .popup(popup):
                if let popupState = state.popup {
                    PopupManager.shared.remove(popupState)
                }
                state.popup = popup
                return .none
            case .login(.dismiss):
                guard let redirection = state.redirection, redirection.isNotEmpty else { return .none }
                state.redirection = nil
                if state.profile.hasLoginedUser {
                    log("登录成功，需重定向: \(redirection)")
                    return .run { send in
                        await send(.target(redirection))
                    }
                }
                return .none
            case let .push(.element(id: _, action: .about(.target(target)))):
                return .run { send in
                    await send(.target(target))
                }
            case let .target(target):
                let result = HiNav.shared.parse(target)
                let should = HiNav.shared.checkNeedLogin(target) && !HiNav.shared.isLogined()
                if let effect = self.routeForward(&state, action, target, result, should) {
                    return effect
                }
                if let effect = self.routeBack(&state, action, target, result, should) {
                    return effect
                }
                if let effect = self.routeExternalURL(&state, action, target, result, should) {
                    return effect
                }
                return .none
            default:
                return .none
            }
        }
        .forEach(\.push, action: \.push)
        .ifLet(\.$alert, action: \.alert)
        .ifLet(\.$sheet, action: \.sheet)
        .ifLet(\.$login, action: \.login) { LoginReducer() }
    }
    
    func routeBack(
        _ state: inout State, _ action: Action, _ target: String, _ result: Any?, _ should: Bool
    ) -> Effect<Action>? {
        guard let back = result as? BackState else { return nil }
        if back.type == .auto || back.type == .popOne {
            _ = state.push.popLast()
        } else if back.type == .dismiss {
            state.login = nil
        }
        return .none
    }
    
    func routeForward(
        _ state: inout State, _ action: Action, _ target: String, _ result: Any?, _ should: Bool
    ) -> Effect<Action>? {
        if let effect = self.routeForwardPush(&state, action, target, result, should) {
            return effect
        }
        if let effect = self.routeForwardPresent(&state, action, target, result, should) {
            return effect
        }
        if let effect = self.routeForwardOpen(&state, action, target, result, should) {
            return effect
        }
        return nil
    }
    
    func routeForwardPresent(
        _ state: inout State, _ action: Action, _ target: String, _ result: Any?, _ should: Bool
    ) -> Effect<Action>? {
        if let login = result as? LoginReducer.State {
            state.login = login
            return .none
        }
        return nil
    }
    
    func routeForwardPush(
        _ state: inout State, _ action: Action, _ target: String, _ result: Any?, _ should: Bool
    ) -> Effect<Action>? {
        guard let path = result as? IOSTemplateWithTCA.Push.State else { return nil }
        if should {
            log("未登录，需要登录后再继续: \(target)")
            state.redirection = target
            return .run { send in
                await send(.target(HiNav.shared.deepLink(host: .login)))
            }
        }
        state.push.append(path)
        return .none
    }
    
    func routeForwardOpen(
        _ state: inout State, _ action: Action, _ target: String, _ result: Any?, _ should: Bool
    ) -> Effect<Action>? {
        if let effect = self.routeForwardOpenToast(&state, action, target, result, should) {
            return effect
        }
        if let effect = self.routeForwardOpenAlert(&state, action, target, result, should) {
            return effect
        }
        if let effect = self.routeForwardOpenSheet(&state, action, target, result, should) {
            return effect
        }
        if let effect = self.routeForwardOpenPopup(&state, action, target, result, should) {
            return effect
        }
        return nil
    }
    
    func routeForwardOpenToast(
        _ state: inout State, _ action: Action, _ target: String, _ result: Any?, _ should: Bool
    ) -> Effect<Action>? {
        guard let toast = result as? ToastState else { return nil }
        if let active = toast.active {
            return .run { send in
                await send(.binding(.set(\.isActivating, active)))
            }
        }
        return .run { send in
            await send(.toastMessage(toast.message))
        }
    }
    
    func routeForwardOpenAlert(
        _ state: inout State, _ action: Action, _ target: String, _ result: Any?, _ should: Bool
    ) -> Effect<Action>? {
        guard let alert = result as? AlertState<ITAlertAction> else { return nil }
        state.alert = alert
        return .none
    }
    
    func routeForwardOpenSheet(
        _ state: inout State, _ action: Action, _ target: String, _ result: Any?, _ should: Bool
    ) -> Effect<Action>? {
        guard let sheet = result as? ConfirmationDialogState<ITAlertAction> else { return nil }
        state.sheet = sheet
        return .none
    }
    
    func routeForwardOpenPopup(
        _ state: inout State, _ action: Action, _ target: String, _ result: Any?, _ should: Bool
    ) -> Effect<Action>? {
        guard let popup = result as? PopupState else { return nil }
        state.popup = popup
        return .none
    }
    
    func routeExternalURL(
        _ state: inout State, _ action: Action, _ target: String, _ result: Any?, _ should: Bool
    ) -> Effect<Action>? {
        guard let urlString = result as? String else { return nil }
        return .run { _ in
            guard let url = urlString.url else { return }
            if await self.application.canOpenURL(url) {
                _ = await self.application.open(url, options: [:])
            } else {
                log("无法处理外部链接：\(target)")
            }
        }
    }
    
}
