//
//  BackState.swift
//  Pods
//
//  Created by 杨建祥 on 2024/11/18.
//

import Foundation

public struct BackState: Identifiable, Equatable {
    
    public let type: BackType
    
    public var id: Int { type.rawValue }
    
    public init(type: BackType) {
        self.type = type
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.type == rhs.type
    }
    
}
