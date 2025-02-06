//
//  Heap.swift
//  HiSwiftUI
//
//  Created by 杨建祥 on 2024/10/6.
//

import Foundation

private final class Reference<T: Equatable>: Equatable {
    var value: T
    init(_ value: T) {
        self.value = value
    }
    static func == (lhs: Reference<T>, rhs: Reference<T>) -> Bool {
        lhs.value == rhs.value
    }
}

@propertyWrapper 
public struct Heap<T: Equatable>: Equatable {
    private var reference: Reference<T>

    public init(_ value: T) {
        reference = .init(value)
    }

    public var wrappedValue: T {
        get { reference.value }
        set {
            if !isKnownUniquelyReferenced(&reference) {
                reference = .init(newValue)
                return
            }
            reference.value = newValue
        }
    }
    
    public var projectedValue: Heap<T> {
        self
    }
}
