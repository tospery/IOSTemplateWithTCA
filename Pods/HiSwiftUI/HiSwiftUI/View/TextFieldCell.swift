//
//  TextFieldCell.swift
//  Pods
//
//  Created by 杨建祥 on 2024/11/17.
//

import SwiftUI
import Combine
import HiResource
import HiSwiftUI

public struct TextFieldCell: View {

    @Binding var text: String
    @Binding var focused: Bool
    var placeholder: String
    var keyboardType: UIKeyboardType
    var characterLimit: Int?
    
    @FocusState private var isFocused: Bool

    public init(
        text: Binding<String>,
        focused: Binding<Bool> = .constant(false),
        placeholder: String = "",
        keyboardType: UIKeyboardType = .default,
        characterLimit: Int? = nil
    ) {
        _text = text
        _focused = focused
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.characterLimit = characterLimit
    }

    public var body: some View {
        VStack {
            TextField(placeholder, text: $text)
                .font(.system(size: 15))
                .lineLimit(1)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .focused($isFocused)
                .keyboardType(keyboardType)
                .padding(.horizontal)
                .onChange(of: isFocused) { newValue in
                    focused = newValue
                }
                .onChange(of: focused) { newValue in
                    isFocused = newValue
                }
                .onChange(of: text) { newValue in
                    if let limit = characterLimit, newValue.count > limit {
                        text = String(newValue.prefix(limit))
                    }
                }
                .onAppear {
                    isFocused = focused
                }
        }
        .frame(height: 44)
        .background(Color.background)
    }
}

