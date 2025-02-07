//
//  PersonalParallaxHeader.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2024/11/14.
//

import SwiftUI
import HiCore
import HiLog
import HiSwiftUI
import Domain

struct PersonalParallaxHeader: View {
    
    let user: Domain.User?
    let action: ((PageType?) -> Void)
    
    init(_ user: Domain.User?, action: @escaping (PageType?) -> Void) {
        self.user = user
        self.action = action
    }
    
    var body: some View {
        R.image.personal_parallax_icon.swiftUIImage
            .resizable()
            .aspectRatio(contentMode: .fill)
            .overlay(alignment: .center) {
                Text(R.string.localizable.clickToLogin.localizedStringKey)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.background)
                    .onTapGesture {
                        action(nil)
                    }
            }
    }
    
}
