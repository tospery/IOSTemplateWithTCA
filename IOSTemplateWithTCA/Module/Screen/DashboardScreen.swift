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
import HiLog

struct DashboardScreen: View {
    
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
//        WithPerceptionTracking {
////            ScrollView {
//////                VStack(spacing: 0) {
//////                    ForEach(store.list.models) { cell($0) }
//////                }
////            }
//            VStack {
//                Text("Dashboard")
//            }
//            .background(Color.surface)
//            .navigationTitle(R.string.localizable.about.localizedStringKey)
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar(.hidden, for: .tabBar)
//            .onAppear {
//                stats(.beginPageView(name: self.className))
//                store.send(.load)
//            }
//            .onDisappear {
//                stats(.endPageView(name: self.className))
//            }
//        }
    }
    
    @ViewBuilder
    func content() -> some View {
        VStack {
            Spacer()
            Text(R.string.localizable.dashboard.localizedKeyString)
                .frame(maxWidth: .infinity)
            Spacer()
        }
        .background(Color.surface)
        .navigationTitle(R.string.localizable.dashboard.localizedKeyString)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { stats(.beginPageView(name: self.className)) }
        .onDisappear { stats(.endPageView(name: self.className)) }
    }
    
//    @ViewBuilder
//    func cell(_ model: Tile) -> some View {
//        let id = TileId(rawValue: model.id) ?? .space
//        if id == .logo {
//            AboutLogoCell {
//                store.send(.increment)
//            }
//        } else {
//            TileCell(model) {
//                if let target = model.target {
//                    store.send(.target(target))
//                } else {
//                    let id = TileId(rawValue: model.id) ?? .space
//                    if id == .share {
//                        share()
//                    }
//                }
//            }
//        }
//    }
    
}
