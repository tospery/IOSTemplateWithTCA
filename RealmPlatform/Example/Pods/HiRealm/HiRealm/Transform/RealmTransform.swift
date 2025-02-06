//
//  RealmTransform.swift
//  HiUIKit
//
//  Created by 杨建祥 on 2024/5/13.
//

import RealmSwift
import ObjectMapper


/// Transforms Swift Arrays to Realm Arrays. E.g. [String] to List<String>.
public class RealmTransform<T: RealmCollectionValue>: TransformType {
    public typealias Object = RealmSwift.List<T>
    public typealias JSON = [Any]
    
    public init() {}
    
    public func transformFromJSON(_ value: Any?) -> RealmSwift.List<T>? {
        guard let array = value as? [Any] else { return nil }
        
        let list = RealmSwift.List<T>()
        let realmValues: [T] = array.compactMap { $0 as? T }
        list.append(objectsIn: realmValues)
        
        return list
    }
    
    public func transformToJSON(_ value: RealmSwift.List<T>?) -> [Any]? {
        guard let value = value else { return nil }
        
        return Array(value)
    }
}
