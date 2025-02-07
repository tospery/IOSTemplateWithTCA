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
                if let target = model.target {
                    store.send(.target(target))
                }
            }
        }
    }
    
}
