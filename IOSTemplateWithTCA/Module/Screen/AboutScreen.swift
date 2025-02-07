//
//  AboutScreen.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2024/11/26.
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

struct AboutScreen: View {
    
    @Perception.Bindable var store: StoreOf<AboutReducer>

    var body: some View {
        WithPerceptionTracking {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(store.list.models) { cell($0) }
                }
            }
            .background(Color.surface)
            .navigationTitle(R.string.localizable.about.localizedStringKey)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
            .onAppear {
                stats(.beginPageView(name: self.className))
                store.send(.load)
            }
            .onDisappear {
                stats(.endPageView(name: self.className))
            }
        }
    }
    
    @ViewBuilder
    func cell(_ model: Tile) -> some View {
        let id = TileId(rawValue: model.id) ?? .space
        if id == .logo {
            AboutLogoCell { }
        } else {
            TileCell(model) {
                if id == .toast {
                    toast()
                } else if id == .alert {
                    alert()
                } else if id == .sheet {
                    sheet()
                } else if id == .popup {
                    popup()
                } else if id == .logic {
                    logic()
                }
            }
        }
    }
    
    func toast() {
        store.send(.target(
            HiNav.shared.toastMessageDeepLink(
                R.string.localizable.toastLoginMessage.localizedString
            )
        ))
    }
    
    func alert() {
        store.send(.target(
            HiNav.shared.alertDeepLink(
                R.string.localizable.prompt.localizedString,
                R.string.localizable.alertClearMessage.localizedString,
                [
                    ITAlertAction.default,
                    ITAlertAction.cancel
                ]
            )
        ))
    }
    
    func sheet() {
        store.send(.target(
            HiNav.shared.sheetDeepLink(
                R.string.localizable.prompt.localizedString,
                R.string.localizable.sheetLogoutMessage.localizedString,
                [
                    ITAlertAction.exit,
                    ITAlertAction.cancel
                ]
            )
        ))
    }
    
    func popup() {
        store.send(.target(
            HiNav.shared.popupDeepLink(
                PopupType.share.rawValue,
                [
                    Parameter.data: "弹窗数据"
                ].jsonString() ?? ""
            )
        ))
    }
    
    func logic() {
        store.send(.target(
            HiNav.shared.logicDeepLink(
                LogicType.contact.rawValue,
                [
                    Parameter.data: "业务数据"
                ].jsonString() ?? ""
            )
        ))
    }
    
}
