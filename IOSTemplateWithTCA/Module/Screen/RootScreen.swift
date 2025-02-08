//
//  RootScreen.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2024/11/17.
//

import SwiftUI
import ComposableArchitecture
import DependenciesAdditions
import SFSafeSymbols
import SwifterSwift
import AlertToast_Hi
import HiBase
import HiCore
import HiSwiftUI
import HiLog

struct RootScreen: View {

    @Perception.Bindable var store: StoreOf<RootReducer>
    @Environment(\.locale) var locale
    
    var body: some View {
        WithPerceptionTracking {
            ZStack {
                TabView(selection: $store.tabBarItemType.sending(\.tabBarItemType)) {
                    // trending
                    DashboardScreen(
                        store: store.scope(
                            state: \.dashboard,
                            action: \.dashboard
                        )
                    )
                    .tabItem {
                        (
                            store.tabBarItemType == .dashboard ?
                            R.image.dashboard_selected_icon.swiftUIImage : R.image.dashboard_normal_icon.swiftUIImage
                        )
                            .renderingMode(.template)
                        Text(R.string.localizable.dashboard.localizedStringKey)
                    }
                    .tag(TabBarItemType.dashboard)
                    // favorite
                    FavoriteScreen(
                        store: store.scope(
                            state: \.favorite,
                            action: \.favorite
                        )
                    )
                    .tabItem {
                        (
                            store.tabBarItemType == .favorite ?
                            R.image.favorite_selected_icon.swiftUIImage : R.image.favorite_normal_icon.swiftUIImage
                        )
                            .renderingMode(.template)
                        Text(R.string.localizable.favorite.localizedStringKey)
                    }
                    .tag(TabBarItemType.favorite)
                    // personal
                    PersonalScreen(
                        store: store.scope(
                            state: \.personal,
                            action: \.personal
                        )
                    )
                    .tabItem {
                        (
                            store.tabBarItemType == .personal ?
                            R.image.personal_selected_icon.swiftUIImage : R.image.personal_normal_icon.swiftUIImage
                        )
                            .renderingMode(.template)
                        Text(R.string.localizable.personal.localizedStringKey)
                    }
                    .tag(TabBarItemType.personal)
                }
                .toolbar(.visible, for: .tabBar)
                .navigationTitle(Text(store.tabBarItemType.title))
                .navigationBarTitleDisplayMode(.inline)
                .onOpenURL { handleURL($0) }
                .onChange(of: store.profile) { profile in
                    log("profile变化了: \(profile)")
                    profileService.send(profile)
                    store.send(.binding(.set(\.profile, profile)))
                }
                .overlay(alignment: .bottom) { overlay() }
                .onAppear {
                    stats(.beginPageView(name: self.className))
                    store.send(.load)
                }
                .onDisappear {
                    stats(.endPageView(name: self.className))
                }
            }
        }
    }
    
    @ViewBuilder
    func overlay() -> some View {
        if store.profile.hasLoginedUser {
            EmptyView()
        } else {
            HStack(spacing: 0) {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: screenWidth / 3.0, height: tabBarHeight - safeArea.bottom)
                    .contentShape(.rect)
                    .onTapGesture {
                        store.send(.login(.favorite))
                    }
            }
        }
    }
    
    func handleURL(_ url: URL) {
        log("root中的onOpenURL: \(url)")
        log("store.tabBarItemType: \(store.tabBarItemType)")
        if url.host() == .root {
            if let value = url.queryParameters?.int(for: Parameter.tabBar),
               let tabBar = TabBarItemType(rawValue: value),
               tabBar != store.tabBarItemType {
                store.send(.tabBarItemType(tabBar))
            }
            return
        }
        switch store.tabBarItemType {
        case .dashboard: store.send(.dashboard(.route(.target(url.absoluteString))))
        case .favorite: store.send(.favorite(.route(.target(url.absoluteString))))
        case .personal: store.send(.personal(.route(.target(url.absoluteString))))
        }
    }
    
}
