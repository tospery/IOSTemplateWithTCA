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
    @Dependency(\.application) var application
    
    private enum CancelID { case login }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Scope(state: \.route, action: \.route) { RouteReducer.init() }
        Reduce { state, action in
            switch action {
            case .login:
//                let token = state.personalToken
//                guard token.isNotEmpty else { return .none }
//                state.authToken = .init(id: token)
//                return .run { [token] send in
//                    await send(.route(.target(HiNav.shared.toastActivityDeepLink(true))))
//                    let userResult = await self.platformClient.network().userService()
//                        .login(token: token).asResult()
//                    await send(.user(userResult))
//                    await send(.route(.target(HiNav.shared.toastActivityDeepLink(false))))
//                }.cancellable(id: CancelID.login)
                return .none
            default:
                return .none
            }
        }
    }
}
