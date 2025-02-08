//
//  DashboardReducer.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2025/2/6.
//

import Foundation
import ComposableArchitecture
import DependenciesAdditions
import SwifterSwift
import HiBase
import HiCore
import HiNav
import HiSwiftUI
import Domain
import HiLog

@Reducer
struct DashboardReducer {
    
    @ObservableState
    struct State: Equatable {
        var route = RouteReducer.State.init()
        var list: ListReducer<Language>.State
        @Shared(.profile) var profile = .default
        init(url: String) {
            var myList = ListReducer<Language>.State.init(url: url)
            myList.shouldRefresh = myList.parameters.bool(for: Parameter.shouldRefresh) ?? false
            myList.shouldLoadMore = myList.parameters.bool(for: Parameter.shouldLoadMore) ?? false
            self.list = myList
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case route(RouteReducer.Action)
        case list(ListReducer<Language>.Action)
        case load
    }
    
    private enum CancelID { case load }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Scope(state: \.route, action: \.route) { RouteReducer.init() }
        Scope(state: \.list, action: \.list) { ListReducer.init() }
        Reduce { _, action in
            switch action {
            case .load:
                return .run { send in
                    await send(.list(.load))
                }
            default:
                return .none
            }
        }
    }
    
}
