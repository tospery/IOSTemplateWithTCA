//
//  ErrorView.swift
//  HiSwiftUI
//
//  Created by 杨建祥 on 2024/10/14.
//

import SwiftUI
import HiCore

public struct ErrorView: View {
    private let error: Error
    private let descriptionOnly: Bool
    private let action: () -> Void

    public init(_ error: Error, descriptionOnly: Bool = false, action: @escaping () -> Void) {
        self.error = error
        self.descriptionOnly = descriptionOnly
        self.action = action
    }

    public var body: some View {
//        VStack {
//            if descriptionOnly {
//                Text((error.asHiError.errorDescription ?? "").localizedStringKey)
//                    .font(.system(size: 14))
//                    .multilineTextAlignment(.center)
//                    .foregroundStyle(Color.primary.opacity(0.4))
//            } else {
//                if let image = error.asHiError.displayImage {
//                    image
//                        .padding(.bottom, 5)
//                }
//                Text((error.asHiError.failureReason ?? "").localizedStringKey)
//                    .font(.system(size: 16))
//                    .multilineTextAlignment(.center)
//                    .foregroundStyle(Color.primary)
//                    .padding(.bottom, 5)
//                Text((error.asHiError.errorDescription ?? "").localizedStringKey)
//                    .font(.system(size: 14))
//                    .multilineTextAlignment(.center)
//                    .foregroundStyle(Color.primary.opacity(0.4))
//            }
//        }
//         .frame(maxWidth: .infinity, maxHeight: .infinity)
//         .background(Color.surface)
//         .contentShape(.rect)
//         .onTapGesture {
//             action()
//         }
        Button {
            action()
        } label: {
            VStack {
                if descriptionOnly {
                    Text((error.asHiError.errorDescription ?? "").localizedStringKey)
                        .font(.system(size: 14))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.primary.opacity(0.4))
                } else {
                    if let image = error.asHiError.displayImage {
                        image
                            .padding(.bottom, 5)
                    }
                    Text((error.asHiError.failureReason ?? "").localizedStringKey)
                        .font(.system(size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.primary)
                        .padding(.bottom, 5)
                    Text((error.asHiError.errorDescription ?? "").localizedStringKey)
                        .font(.system(size: 14))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.primary.opacity(0.4))
                }
            }
             .frame(maxWidth: .infinity, maxHeight: .infinity)
             .contentShape(.rect)
        }
        .buttonStyle(.plain)
    }
}
