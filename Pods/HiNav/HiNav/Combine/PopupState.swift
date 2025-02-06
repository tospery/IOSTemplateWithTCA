//
//  PopupState.swift
//  Pods
//
//  Created by 杨建祥 on 2024/12/21.
//

import Foundation

public struct PopupState: Identifiable, Equatable {
    
    public let id: String
    public var type: String
    public var data: String?
    
    public init(type: String, data: String? = nil) {
        self.id = UUID().uuidString
        self.type = type
        self.data = data
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
        && lhs.type == rhs.type
        && lhs.data == rhs.data
    }
    
}
