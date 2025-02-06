//
//  PopupManager.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2024/12/22.
//

import SwiftUI
import HiSwiftUI
import HiLog
import HiNav
import ExytePopupView

class PopupManager {
    
    private var type: String?
    private var shareScreen: ShareScreen?
    
    static var shared = PopupManager()
    
    init() { }
    
    @ViewBuilder
    func popupView(for state: PopupState) -> some View {
        if state.type == PopupType.share.rawValue {
            if let screen = self.shareScreen {
                screen
            } else {
                self.createShareScreen(for: state)
            }
        } else {
            EmptyView()
        }
    }
    
    func popupParameters<PopupContent: View>(
        for state: PopupState?,
        with param: Popup<PopupContent>.PopupParameters
    ) -> Popup<PopupContent>.PopupParameters {
        let type = state?.type == nil ? self.type : state?.type
        if type == PopupType.share.rawValue {
            return param
                .type(.floater(verticalPadding: 0, useSafeAreaInset: false))
                .position(.bottom)
                .closeOnTap(false)
                .closeOnTapOutside(true)
                .backgroundColor(.primary.opacity(0.4))
        } else {
            return param
        }
    }
    
    func remove(_ state: PopupState) {
        if state.type == PopupType.share.rawValue {
            self.shareScreen = nil
        }
    }

    private func createShareScreen(for state: PopupState) -> ShareScreen {
        self.type = state.type
        let screen = ShareScreen(
            store: .init(
                initialState: ShareReducer.State(url: HiNav.shared.popupDeepLink(
                    state.type,
                    state.data
                )),
                reducer: { ShareReducer() }
            )
        )
        self.shareScreen = screen
        return screen
    }

}
