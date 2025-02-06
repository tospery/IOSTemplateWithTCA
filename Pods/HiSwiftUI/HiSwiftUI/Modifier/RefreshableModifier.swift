//
//  RefreshableModifier.swift
//  Pods
//
//  Created by 杨建祥 on 2024/11/24.
//

import SwiftUI

struct RefreshableModifier: ViewModifier {
    let isRefreshable: Bool
    @MainActor
    let action: @Sendable () async -> Void
    
    init(isRefreshable: Bool, action: @MainActor @Sendable @escaping () async -> Void) {
        self.isRefreshable = isRefreshable
        self.action = action
    }

    func body(content: Content) -> some View {
        if isRefreshable {
            content.refreshable {
                await action()
            }
        } else {
            content
        }
    }
}
