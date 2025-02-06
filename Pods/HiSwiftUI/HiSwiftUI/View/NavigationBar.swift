//
//  NavigationBar.swift
//  Pods
//
//  Created by 杨建祥 on 2025/1/6.
//

import SwiftUI
import HiCore
import HiNav
import HiSwiftUI

public struct NavigationBar: View {
    
    public let title: String?
    public let back: ((BackType) -> Void)?
    @Environment(\.dismiss) private var dismiss
    
    public init(_ title: String? = nil, back: ((BackType) -> Void)? = nil) {
        self.title = title
        self.back = back
    }

    public var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: statusBarHeightConstant)
            HStack(spacing: 0) {
                UIImage.back.swiftUIImage
                    .renderingMode(.template)
                    .font(.system(size: 18))
                    .frame(width: navigationBarHeight * 1.2, height: navigationBarHeight)
                    .foregroundStyle(Color.primary)
                    .onTapGesture {
                        dismiss()
                    }
                Spacer()
                Text(title ?? "")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(Color.primary)
                Spacer()
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: navigationBarHeight * 1.2)
            }
        }
        .frame(height: navigationContentTopConstant)
        .frame(maxWidth: .infinity)
        .background(Color.container)
    }
    
}
