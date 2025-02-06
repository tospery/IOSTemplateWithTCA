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
        @Shared(.profile) var profile = .default
        init(url: String) {
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case load
    }
    
    private enum CancelID { case load }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .load:
                return .none
            default:
                return .none
            }
        }
    }
    
}
