//
//  TextCell.swift
//  Pods
//
//  Created by 杨建祥 on 2024/11/19.
//

import SwiftUI
import HiBase
import HiCore

public struct TextCell: View {
    
    let alignment: HorizontalAlignment
    var attributedText: AttributedString
    
    public init(
        _ attributedText: AttributedString,
        alignment: HorizontalAlignment = .leading
    ) {
        self.attributedText = attributedText
        self.alignment = alignment
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            Spacer()
            Text(attributedText)
                .multilineTextAlignment(.trailing)
                .padding(.horizontal, 15)
        }
        .background(Color.clear)
    }
    
}
