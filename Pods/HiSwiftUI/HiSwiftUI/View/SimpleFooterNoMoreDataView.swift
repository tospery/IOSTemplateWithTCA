//
//  SimpleFooterNoMoreDataView.swift
//  Pods
//
//  Created by 杨建祥 on 2024/12/3.
//

import SwiftUI

public struct SimpleFooterNoMoreDataView: View {
    
    public init() { }
    
    public var body: some View {
        VStack {
            Text("Footer.NoMoreData.Text")
                .font(.system(size: 13))
                .foregroundStyle(Color.secondary)
        }
        .frame(height: 32)
    }
    
}

