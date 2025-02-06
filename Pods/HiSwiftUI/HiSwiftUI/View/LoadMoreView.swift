//
//  LoadMoreView.swift
//  Pods
//
//  Created by 杨建祥 on 2024/11/22.
//

import SwiftUI

public struct LoadMoreView: View {
    
    let noMoreData: Bool
    let error: Error?
    
    public init(noMoreData: Bool, error: Error?) {
        self.noMoreData = noMoreData
        self.error = error
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            Spacer()
            if noMoreData {
                Text("List.NoMoreData.Hint".localizedStringKey)
                    .font(.system(size: 14))
                    .foregroundStyle(Color.primary.opacity(0.8))
            } else {
                if let error = error {
                    Text(error.localizedDescription)
                        .font(.system(size: 14))
                        .foregroundStyle(Color.primary.opacity(0.8))
                } else {
                    ProgressView()
                }
            }
            Spacer()
        }
        .frame(height: 40)
        .background(Color.surface)
    }
    
}
