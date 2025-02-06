//
//  SimpleHeaderRefreshingView.swift
//  Pods
//
//  Created by 杨建祥 on 2024/12/3.
//

import SwiftUI

public struct SimpleHeaderRefreshingView: View {
    
    public init() { }
    
    public var body: some View {
        VStack {
            ProgressView()
        }
        .frame(height: 32)
    }
    
}
