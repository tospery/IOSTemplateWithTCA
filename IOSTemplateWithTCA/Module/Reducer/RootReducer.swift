//
//  RootReducer.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2024/11/17.
//

import SwiftUI
import Combine
import ComposableArchitecture
import DependenciesAdditions
import RealmSwift
import HiBase
import HiCore
import HiNav
import HiSwiftUI
import Domain
import HiLog

@Reducer
struct RootReducer {
    
    @ObservableState
    struct State: Equatable {
        @Shared(.profile) var profile = .default
        var tabBarItemType = TabBarItemType.dashboard
        var dashboard = DashboardReducer.State.init(url: HiNav.shared.deepLink(host: .dashboard))
        var favorite = FavoriteReducer.State.init(url: HiNav.shared.deepLink(host: .favorite))
        var personal = PersonalReducer.State.init()
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        
        case onScenePhaseChange(ScenePhase)
        case databaseInitialized(Result<Domain.Profile, Error>)
        
        case tabBarItemType(TabBarItemType)
        case dashboard(DashboardReducer.Action)
        case favorite(FavoriteReducer.Action)
        case personal(PersonalReducer.Action)
        
        case load
        case login(TabBarItemType)
    }
    
    @Dependency(\.continuousClock) var clock
    @Dependency(\.application) var application
    @Dependency(\.platformClient) var platformClient
    private enum CancelID { case load, login }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case let .tabBarItemType(tabBarItemType):
                state.tabBarItemType = tabBarItemType
                return .none
            case .load:
                log("展示了root")
                return .run { send in
                    // _ = await DatabaseManager.shared.exampleData().asResult()
                    await send(.databaseInitialized(await self.databaseInitialize()))
                }.cancellable(id: CancelID.load)
            case let .login(tabBarItemType):
                return .run { _ in
                    _ = await self.application.open(
                        HiNav.shared.deepLink(host: .login, parameters: [
                            Parameter.tabBar: tabBarItemType.rawValue.string
                        ]).url!,
                        options: [:]
                    )
                }.cancellable(id: CancelID.login)
            case let .databaseInitialized(.success(profile)):
                state.profile = profile
                return .none
            case let .databaseInitialized(.failure(error)):
                log("样本数据库失败: \(error)")
                return .none
            case .binding(\.profile):
                log("profile需要保存了。。。")
                let profile = state.profile
                return .run { [profile] _ in
                    _ = await self.platformClient.network().profileService().save(profile: profile).asResult()
                    _ = await self.platformClient.database().profileService().save(profile: profile).asResult()
                }
            default:
                return .none
            }
        }
        Scope(state: \.dashboard, action: \.dashboard) { DashboardReducer.init() }
        Scope(state: \.favorite, action: \.favorite) { FavoriteReducer.init() }
        Scope(state: \.personal, action: \.personal) { PersonalReducer.init() }
    }
    
    func databaseInitialize() async -> Result<Domain.Profile, Error> {
        let migration = await DatabaseManager.shared.performMigration().asResult()
        if case let .failure(error)  = migration {
            return .failure(error)
        }
        let fetch = await self.platformClient.database().profileService().profile().asResult()
        if case let .failure(error)  = fetch {
            return .failure(error)
        }
        var profile = Domain.Profile.default
        if case let .success(value) = fetch {
            if let data = value {
                profile = data
            }
        }
        let save = await self.platformClient.network().profileService().save(profile: profile).asResult()
        if case let .failure(error) = save {
            return .failure(error)
        }
        
        return .success(profile)
    }
    
}
