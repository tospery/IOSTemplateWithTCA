//
//  FavoriteReducer.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2024/11/17.
//

import Foundation
import ComposableArchitecture
import DependenciesAdditions
import SwifterSwift
import HiBase
import HiCore
import HiSwiftUI
import Domain
import HiLog

@Reducer
struct FavoriteReducer {
    
    @ObservableState
    struct State: Equatable {
        var route = RouteReducer.State.init()
        var title = R.string.localizable.favorite.localizedString
        @Shared(.profile) var profile = .default
        init(url: String) {
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case list(ListReducer<Repo>.Action)
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
