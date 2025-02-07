//
//  ShareReducer.swift
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
struct ShareReducer {
    
    @ObservableState
    struct State: Equatable {
        let url: String
        let parameters: [String: String]
        var route = RouteReducer.State.init()
        @Shared(.profile) var profile = .default
        init(url: String) {
            self.parameters = url.url?.queryParameters ?? [:]
            self.url = self.parameters.string(for: Parameter.url) ?? url
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case route(RouteReducer.Action)
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
