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
import HiNav
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
        case logout
    }
    
    @Dependency(\.application) var application
    private enum CancelID { case logout }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Scope(state: \.route, action: \.route) { RouteReducer.init() }
        Reduce { state, action in
            switch action {
            case .logout:
                var profile = state.profile
                profile.user = nil
                state.profile = profile
                return .run { _ in
                    _ = await self.application.open(
                        HiNav.shared.deepLink(host: .root, parameters: [
                            Parameter.tabBar: 0.string
                        ]).url!,
                        options: [:]
                    )
                }.cancellable(id: CancelID.logout)
            default:
                return .none
            }
        }
    }
    
}
