//
//  LoginReducer.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2024/11/17.
//

import Foundation
import ComposableArchitecture
import DependenciesAdditions
import HiBase
import HiCore
import HiNav
import HiSwiftUI
import Domain
import HiLog

@Reducer
struct LoginReducer {
    
    @ObservableState
    struct State: Equatable {
        @Shared(.profile) var profile = .default
        var route = RouteReducer.State.init()
        var error: HiError?
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case route(RouteReducer.Action)
        case login
        case user(Result<User, Error>)
    }
    
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.continuousClock) var clock
    
    private enum CancelID { case login, user }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Scope(state: \.route, action: \.route) { RouteReducer.init() }
        Reduce { state, action in
            switch action {
            case .login:
                return .run { send in
                    await send(.route(.target(HiNav.shared.toastActivityDeepLink(true))))
                    try await self.clock.sleep(for: .seconds(3))
                    await send(.user(.success(User.init(JSON: ["id": "1", "username": "demo"])!)))
                    await send(.route(.target(HiNav.shared.toastActivityDeepLink(false))))
                }.cancellable(id: CancelID.login)
            case let .user(.success(user)):
                var profile = state.profile
                profile.user = user
                state.profile = profile
                return .run { _ in
                    await dismiss()
                }.cancellable(id: CancelID.user)
            default:
                return .none
            }
        }
    }
}
