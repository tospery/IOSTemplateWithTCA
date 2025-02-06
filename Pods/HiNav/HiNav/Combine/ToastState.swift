//
//  ToastState.swift
//  Pods
//
//  Created by 杨建祥 on 2024/11/14.
//

import Foundation

public struct ToastState: Identifiable, Equatable {
    
    public let id: UUID
    public var active: Bool?
    public var message: String
    
    public init(message: String = "", active: Bool? = nil) {
        self.id = .init()
        self.message = message
        self.active = active
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.active == rhs.active
        && lhs.message == rhs.message
    }
    
}
