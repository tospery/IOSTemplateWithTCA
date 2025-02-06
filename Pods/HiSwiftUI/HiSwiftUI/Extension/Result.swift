//
//  Result.swift
//  Pods
//
//  Created by 杨建祥 on 2024/12/29.
//

import Foundation

public extension Result {
    
    var value: Success? {
        guard case let .success(value) = self else { return nil }
        return value
    }
    
}
