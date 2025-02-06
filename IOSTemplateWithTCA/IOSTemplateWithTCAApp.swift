//
//  IOSTemplateWithTCAApp.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2025/2/6.
//

import SwiftUI
import ComposableArchitecture
import SFSafeSymbols
import AlertToast_Hi
import HiSwiftUI
import HiBase
import HiNav
import HiLog
import Domain

@main
struct IOSTemplateWithTCAApp: App {
    
    @Shared(.profile) var profile = .default
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        Appdata.shared.inject(profile)
        Runtime.shared.work()
        Library.shared.setup()
        Appearance.shared.config()
    }

    var body: some Scene {
        WindowGroup {
            RootScreen(store: Store(initialState: RootReducer.State.init(), reducer: {
                RootReducer()
            }))
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                logEnvironment()
            }
        }
    }

}
