//
//  DashboardScreen.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2025/2/6.
//

import SwiftUI
import Combine
import ComposableArchitecture
import SFSafeSymbols
import SwifterSwift
import AlertToast_Hi
import Kingfisher
import HiBase
import HiCore
import HiNav
import HiSwiftUI
import Domain
import NetworkPlatform
import Refresh_Hi
import HiLog

struct DashboardScreen: View {
    
    @State var hasLoaded = false
    @Perception.Bindable var store: StoreOf<DashboardReducer>

    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.route.push, action: \.route.push)) {
                content()
            } destination: {
                Push.destination($0)
            }
            .withRouteHandling(
                route: store.scope(state: \.route, action: \.route),
                alert: $store.scope(state: \.route.alert, action: \.route.alert),
                sheet: $store.scope(state: \.route.sheet, action: \.route.sheet),
                login: $store.scope(state: \.route.login, action: \.route.login)
            )
        }
    }
    
    @ViewBuilder
    func content() -> some View {
        ScrollView {
            let last = store.list.models.last
            LazyVStack(spacing: 0) {
                ForEach(store.list.models) { cell($0, last) }
            }
        }
        .navigationTitle(R.string.localizable.dashboard.localizedStringKey)
        .navigationBarTitleDisplayMode(.inline)
        .overlay { loadOverlay() }
        .onAppear {
            stats(.beginPageView(name: self.className))
            if hasLoaded {
                store.send(.list(.refresh))
                return
            }
            hasLoaded = true
            store.send(.load)
        }
        .onDisappear {
            stats(.endPageView(name: self.className))
        }
    }
    
    @ViewBuilder
    func cell(_ model: Language, _ last: Language?) -> some View {
        VStack(spacing: 0) {
            LanguageCell(model) {}
            if model != last {
                Separator()
                    .padding(.leading)
            }
        }
    }
    
    @ViewBuilder
    func loadOverlay() -> some View {
        if store.list.isLoading {
            ProgressView()
        } else {
            if let error = store.list.error {
                ErrorView(error) { store.send(.load) }
            } else {
                EmptyView()
            }
        }
    }
    
}
