//
//  PersonalScreen.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2024/11/17.
//

import SwiftUI
import ComposableArchitecture
import DependenciesAdditions
import AlertToast_Hi
import SwiftUIKit_Hi
import ExytePopupView
import SFSafeSymbols
import SwifterSwift
import FancyScrollView_Hi
import RswiftResources
import Kingfisher
import HiBase
import HiCore
import HiNav
import HiSwiftUI
import Domain
import HiLog

struct PersonalScreen: View {
    @State var hasLoaded = false
    @Perception.Bindable var store: StoreOf<PersonalReducer>
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.route.push, action: \.route.push)) {
                FancyScrollView(
                    title: R.string.localizable.personal.localizedKeyString,
                    titleColor: .clear,
                    headerHeight: 488.0 / 780.0 * screenWidth,
                    scrollUpHeaderBehavior: .parallax,
                    scrollDownHeaderBehavior: .offset,
                    header: {
                        PersonalParallaxHeader(store.profile.user) { tapPageType($0) }
                    },
                    content: { content() }
                )
                .background(Color.surface)
                .onAppear {
                    stats(.beginPageView(name: self.className))
                    if hasLoaded {
                        return
                    }
                    hasLoaded = true
                    store.send(.load)
                }
                .onDisappear {
                    stats(.endPageView(name: self.className))
                }
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
    
    func tapPageType(_ pageType: PageType?) {
        store.send(.route(.target(HiNav.shared.deepLink(host: .login))))
    }
    
    @ViewBuilder
    func content() -> some View {
        ScrollView {
            VStack(spacing: 0) {
                TileCell(.space())
                ForEach(TileId.unloginValues) { id in
                    TileCell(.init(
                        id: id.id,
                        icon: id.icon,
                        title: id.description,
                        separated: id.separated,
                        indicated: id.indicated
                    )) {
                        store.send(.route(.target(TileId.about.target ?? "")))
                    }
                }
            }
        }
        .background(Color.surface)
    }
    
}
