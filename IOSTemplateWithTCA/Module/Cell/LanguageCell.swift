//
//  LanguageCell.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2024/11/17.
//

import SwiftUI
import HiCore
import Domain

struct LanguageCell: View {
    let model: Language
    let action: () -> Void
    
    init(_ model: Language, action: @escaping () -> Void) {
        self.model = model
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading) {
                HStack {
                    Circle()
                        .fill((model.name ?? "").hashColor.swiftUIColor)
                        .frame(width: 16, height: 16)
                        .padding(.leading)
                    Text(model.name ?? "")
                        .font(.callout)
                        .foregroundStyle(Color.primary)
                    Spacer()
                }
            }
            .frame(height: 44)
        }
    }
}
