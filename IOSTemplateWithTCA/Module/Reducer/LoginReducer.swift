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
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Scope(state: \.route, action: \.route) { RouteReducer.init() }
        Reduce { _, action in
            switch action {
            default:
                return .none
            }
        }
    }
}
