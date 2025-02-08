//
//  LoginScreen.swift
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
import HiCore
import HiNav
import HiSwiftUI
import HiLog

struct LoginScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @Perception.Bindable var store: StoreOf<LoginReducer>
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.route.push, action: \.route.push)) {
                content()
                .navigationTitle(R.string.localizable.login.localizedStringKey)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemSymbol: .xmark)
                                .font(.system(size: 15))
                                .foregroundStyle(Color.primary)
                        }
                    }
                }
                .toolbarBackground(Color.clear, for: .navigationBar)
                .onAppear {
                    stats(.beginPageView(name: self.className))
                }
                .onDisappear {
                    stats(.endPageView(name: self.className))
                }
            } destination: {
                Push.destination($0)
            }
            .environment(\.colorScheme, (store.profile.isDark ?? false) ? .dark : .light)
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
            Text("模拟成功登录一个用户")
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    store.send(.login)
                }
            Spacer()
        }
        .background(Color.surface)
    }
    
}
