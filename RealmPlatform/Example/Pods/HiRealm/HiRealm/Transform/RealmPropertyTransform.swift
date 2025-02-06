//
//  RealmPropertyTransform.swift
//  HiUIKit
//
//  Created by 杨建祥 on 2024/5/13.
//

import RealmSwift
import ObjectMapper

/// Transforms Swift numeric to `RealmProperty<T>`.
/// E.g. `Int?` to `RealmProperty<Int>` or `Double` to `RealmProperty<Int>`.
public class RealmPropertyTransform<T: RealmOptionalType & _RealmSchemaDiscoverable>: TransformType {
    public typealias Object = RealmProperty<T?>
    public typealias JSON = Any
    
    public init() {}
    
    public func transformFromJSON(_ value: Any?) -> RealmProperty<T?>? {
        let realmProperty = RealmProperty<T?>()
        guard let value = value as? T else { return realmProperty }
        
        realmProperty.value = value
        
        return realmProperty
    }
    
    public func transformToJSON(_ value: RealmProperty<T?>?) -> Any? {
        return value?.value
    }
}
