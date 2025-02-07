//
//  PersonalReducer.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2024/11/17.
//

import SwiftUI
import ComposableArchitecture
import DependenciesAdditions
import AlertToast_Hi
import SwiftUIKit_Hi
import SFSafeSymbols
import FancyScrollView_Hi
import Kingfisher
import HiBase
import HiCore
import HiSwiftUI
import Domain
import HiLog

@Reducer
struct PersonalReducer {
    
    @ObservableState
    struct State: Equatable {
        var route = RouteReducer.State.init()
        @Shared(.profile) var profile = .default
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case route(RouteReducer.Action)
        case load
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
