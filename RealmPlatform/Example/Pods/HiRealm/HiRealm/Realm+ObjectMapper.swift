//
//  Realm+ObjectMapper.swift
//  HiUIKit
//
//  Created by 杨建祥 on 2024/5/13.
//

import Foundation
import ObjectMapper
import RealmSwift

public extension Object {
    
    /// `.toJSON()` requires Realm write transaction or it'll crash
    /// https://github.com/APUtils/ObjectMapperAdditions#realm-features
    func performMapping(_ action: () -> Void) {
        let isWriteRequired = realm != nil && realm?.isInWriteTransaction == false
        if isWriteRequired { realm?.beginWrite() }
        action()
        if isWriteRequired { realm?.cancelWrite() }
    }
}

public extension EmbeddedObject {
    
    /// `.toJSON()` requires Realm write transaction or it'll crash
    /// https://github.com/APUtils/ObjectMapperAdditions#realm-features
    func performMapping(_ action: () -> Void) {
        let isWriteRequired = realm != nil && realm?.isInWriteTransaction == false
        if isWriteRequired { realm?.beginWrite() }
        action()
        if isWriteRequired { realm?.cancelWrite() }
    }
}
