//
//  FavoriteScreen.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2024/11/17.
//

import SwiftUI
import Combine
import ComposableArchitecture
import DependenciesAdditions
import SFSafeSymbols
import SwifterSwift
import AlertToast_Hi
import SwiftUIKit_Hi
import ExytePopupView
import HiCore
import HiSwiftUI
import Refresh_Hi
import Domain
import HiLog

struct FavoriteScreen: View {
    @Perception.Bindable var store: StoreOf<FavoriteReducer>
    @State var hasLoaded = false
    
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
        VStack {
            Spacer()
            Text("登录后、才能查看的Tab页（点击退出登录）")
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    store.send(.logout)
                }
            Spacer()
        }
        .background(Color.surface)
        .navigationTitle(R.string.localizable.favorite.localizedKeyString)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { stats(.beginPageView(name: self.className)) }
        .onDisappear { stats(.endPageView(name: self.className)) }
    }
    
}
