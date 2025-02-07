//
//  ShareScreen.swift
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
import ExytePopupView
import HiLog

struct ShareScreen: View {
    
    @Environment(\.popupDismiss) var dismiss
    @Perception.Bindable var store: StoreOf<ShareReducer>

    var body: some View {
        WithPerceptionTracking {
            content()
            .onAppear {
                stats(.beginPageView(name: self.className))
            }
            .onDisappear {
                stats(.endPageView(name: self.className))
            }
        }
    }
    
    @ViewBuilder
    func content() -> some View {
        VStack {
            
        }
        .toolbar(.hidden, for: .tabBar)
        .frame(width: (screenWidth * 0.7).flat, height: (screenWidth * 0.8).flat)
        .background(Color.orange)
        .clipShape(.rect(cornerRadius: 16))
    }
    
}
