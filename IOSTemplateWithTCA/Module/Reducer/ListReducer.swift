//
//  ListReducer.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2024/11/24.
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
struct ListReducer<Model: ModelType> {
    
    @ObservableState
    struct State: Equatable {
        let url: String
        let parameters: [String: String]
        let host: String
        let page: PageType
        let pageStart: Int
        let pageSize: Int
        
        var isLoading = true
        var isRefreshing = false
        var isLoadingMore = false
        var noMoreData = false
        var shouldRefresh = false
        var shouldLoadMore = false
        var fromDatabase = false
        var pageIndex = UIApplication.shared.pageStart
        var models = [Model].init()
        var error: HiError?
        @Shared(.profile) var profile = .default
        
        init(url: String) {
            self.url = url
            self.parameters = self.url.url?.queryParameters ?? [:]
            self.host = self.url.routeHost
            self.page = self.parameters.enum(for: Parameter.page, type: PageType.self) ?? .none
            self.pageStart = self.parameters.int(for: Parameter.pageIndex)
                ?? UIApplication.shared.pageStart
            self.pageSize = self.parameters.int(for: Parameter.pageSize)
                ?? UIApplication.shared.pageSize
            self.shouldRefresh = self.parameters.bool(for: Parameter.shouldRefresh) ?? false
            self.shouldLoadMore = self.parameters.bool(for: Parameter.shouldLoadMore) ?? false
            self.pageIndex = self.pageStart
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case load
        case refresh
        case loadMore
        case models(Result<[Model], Error>)
    }
    
    @Dependency(\.continuousClock) var clock
    @Dependency(\.platformClient) var platformClient
    private enum CancelID { case load, refresh, loadMore }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .load:
                return self.load(&state, action).cancellable(id: CancelID.load)
            case .refresh:
                return self.refresh(&state, action).cancellable(id: CancelID.refresh)
            case .loadMore:
                return self.loadMore(&state, action).cancellable(id: CancelID.loadMore)
            case let .models(.success(models)):
                return self.models(&state, action, models)
            case let .models(.failure(error)):
                return self.error(&state, action, error)
            default:
                return .none
            }
        }
    }
    
    func load(_ state: inout State, _ action: Action) -> Effect<Action> {
        state.isLoading = true
        if state.host == .dashboard {
            return self.requestRepos(&state, action, .load)
        }
        return .none
    }
    
    func refresh(_ state: inout State, _ action: Action) -> Effect<Action> {
        state.isRefreshing = true
        if state.host == .dashboard {
            return self.requestRepos(&state, action, .refresh)
        }
        return .none
    }
    
    func loadMore(_ state: inout State, _ action: Action) -> Effect<Action> {
        if state.noMoreData {
            return .none
        }
        state.isLoadingMore = true
        if state.host == .dashboard {
            return self.requestRepos(&state, action, .loadMore)
        }
        return .none
    }
    
    func models(_ state: inout State, _ action: Action, _ models: [Model]) -> Effect<Action> {
        state.noMoreData = models.count < state.pageSize
        if state.isLoadingMore {
            var myModels = state.models
            myModels.append(contentsOf: models)
            state.models = myModels
        } else {
            state.models = models
        }
        state.error = nil
        if state.fromDatabase {
            if models.isEmpty {
                return .none
            } else {
                log("加载数据库数据完成---\(state.host)")
                state.isLoading = false
            }
        } else {
            if !state.isLoadingMore && !models.isEmpty {
                // 需要保存到数据库的数据在此处理
            }
        }
        return .none
    }
    
    func error(_ state: inout State, _ action: Action, _ error: Error) -> Effect<Action> {
        if state.isLoading || state.isRefreshing {
            state.models = []
        }
        state.error = error.asHiError
        return .none
    }
    
    func requestRepos(_ state: inout State, _ action: Action, _ mode: HiRequestMode) -> Effect<Action> {
        let pageIndex = mode == .loadMore ? state.pageIndex : state.pageStart
        let pageSize = state.pageSize
        return .run { send in
            await send(.models(
                unsafeBitCast(
                    await self.platformClient.network().repoService()
                        .search(keyword: "swift", pageIndex: pageIndex, pageSize: pageSize)
                        .asResult(),
                    to: Result<[Model], Error>.self
                )
            ))
            if mode == .refresh {
                await send(.binding(.set(\.isRefreshing, false)))
            } else if mode == .loadMore {
                await send(.binding(.set(\.isLoadingMore, false)))
            } else {
                await send(.binding(.set(\.isLoading, false)))
            }
            await send(.binding(.set(\.pageIndex, pageIndex + 1)))
        }
    }

}
