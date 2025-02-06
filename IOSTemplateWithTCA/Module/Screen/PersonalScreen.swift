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
                    headerHeight: 586.0 / 780.0 * screenWidth,
                    scrollUpHeaderBehavior: .parallax,
                    scrollDownHeaderBehavior: .offset,
                    header: {
                        PersonalParallaxHeader(user: store.profile.user) { tapPageType($0) }
                        .onTapGesture { tapUser() }
                    },
                    content: { content() }
                )
                .background(Color.surface)
//                .onChange(of: store.profile.user?.id) { _ in store.send(.load) }
//                .onChange(of: store.profile.colorTheme) { _ in store.send(.load) }
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
    
    func tapUser() {
//        if store.profile.hasLoginedUser {
//            store.send(.route(.target(HiNav.shared.deepLink(host: .profile))))
//        } else {
//            store.send(.route(.target(HiNav.shared.deepLink(host: .login))))
//        }
    }
    
    func tapPageType(_ pageType: PageType?) {
//        if pageType == nil {
//            store.send(.dark)
//            return
//        }
//        store.send(.route(.target(HiNav.shared.deepLink(host: .page, parameters: [
//            Parameter.owner: store.profile.user?.username ?? "",
//            Parameter.index: PageType.userValues.firstIndex(of: pageType!)?.string ?? "",
//            Parameter.pages: PageType.userValues.map { $0.rawValue }.jsonString() ?? ""
//        ]))))
    }
    
    @ViewBuilder
    func content() -> some View {
        EmptyView()
//        ScrollView {
//            VStack(spacing: 0) {
//                if store.profile.hasLoginedUser {
//                    UserMilestoneCell($store.milestone) { }
//                    TileCell(.space(height: 8))
//                    ForEach(TileId.loginedValues) { id in
//                        cellForLogined(id)
//                    }
//                } else {
//                    ForEach(TileId.unloginValues) { id in
//                        TileCell(.init(
//                            id: id.id,
//                            icon: id.icon,
//                            title: id.description,
//                            separated: id.separated,
//                            indicated: true
//                        )) {
//                            store.send(.route(.target(id.target ?? "")))
//                        }
//                    }
//                }
//            }
//        }
//        .frame(maxWidth: .infinity)
//        .frame(height: screenHeight - (586.0 / 780.0 * screenWidth) - tabBarHeight)
//        .background(Color.surface)
    }
    
    @ViewBuilder
    func cellForLogined(_ id: TileId) -> some View {
        EmptyView()
//        switch id {
//        case .company:
//            UserCompanyCell(
//                store.profile.user?.companyWithDefault.1 ?? "",
//                store.profile.user?.companyWithDefault.0 ?? true
//            )
//        case .location:
//            TileCell(.init(
//                id: id.id,
//                icon: id.icon,
//                title: store.profile.user?.location,
//                separated: id.separated,
//                autoLinked: false
//            ))
//        case .email:
//            TileCell(.init(
//                id: id.id,
//                icon: id.icon,
//                title: store.profile.user?.email,
//                separated: id.separated,
//                indicated: !((store.profile.user?.email?.isEmpty ?? true)),
//                autoLinked: false
//            )) {
//                store.send(.route(.target(store.profile.user?.email?.emailLink ?? "")))
//            }
//        case .blog:
//            TileCell(.init(
//                id: id.id,
//                icon: id.icon,
//                title: store.profile.user?.blogWithDefault.1 ?? "",
//                separated: id.separated,
//                indicated: !((store.profile.user?.blog?.isEmpty ?? true)),
//                autoLinked: false
//            )) {
//                store.send(.route(.target(store.profile.user?.blog ?? "")))
//            }
//        case .space:
//            TileCell(.space())
//        default:
//            TileCell(.init(
//                id: id.id,
//                icon: id.icon,
//                title: id.description,
//                separated: id.separated,
//                indicated: true
//            )) {
//                store.send(.route(.target(id.target ?? "")))
//            }
//        }
    }
    
}
