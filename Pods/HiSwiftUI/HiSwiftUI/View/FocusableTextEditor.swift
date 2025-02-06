//
//  FocusableTextEditor.swift
//  Pods
//
//  Created by 杨建祥 on 2024/11/18.
//

import UIKit
import SwiftUI
import Combine

public struct FocusableTextEditor: UIViewRepresentable {
    
    @Binding var text: String
    @Binding var focused: Bool
    var placeholder: String?
    var keyboardType = UIKeyboardType.default
    var characterLimit: Int?
    
    public func makeUIView(context: Context) -> some UIView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.isScrollEnabled = true
        textView.font = .systemFont(ofSize: 15)
        textView.backgroundColor = .clear
        textView.keyboardType = keyboardType
        textView.placeholder = placeholder
        return textView
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let textView = uiView as? UITextView else { return }
//        if let limit = characterLimit, text.count > limit {
//            textView.text = String(text.prefix(limit))
//        } else {
//            textView.text = text
//        }
        textView.text = text
        if focused && !textView.isFirstResponder {
            textView.becomeFirstResponder()
        } else if !focused && textView.isFirstResponder {
            textView.resignFirstResponder()
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public class Coordinator: NSObject, UITextViewDelegate {
        var parent: FocusableTextEditor
        
        init(_ parent: FocusableTextEditor) {
            self.parent = parent
        }
        
        public func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }

        public func textViewDidBeginEditing(_ textView: UITextView) {
            parent.focused = true
        }

        public func textViewDidEndEditing(_ textView: UITextView) {
            parent.focused = false
        }
    }
}
