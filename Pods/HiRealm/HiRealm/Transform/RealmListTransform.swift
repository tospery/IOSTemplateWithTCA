//
//  RealmListTransform.swift
//  HiUIKit
//
//  Created by 杨建祥 on 2024/5/13.
//

import Foundation
import ObjectMapper
import RealmSwift

public struct RealmListTransform<T: RealmSwift.Object>: TransformType where T: BaseMappable {
    
    public init() { }
    
    public typealias Object = RealmSwift.List<T>
    public typealias JSON = Array<Any>
    
    public func transformFromJSON(_ value: Any?) -> RealmSwift.List<T>? {
        if let objects = Mapper<T>().mapArray(JSONObject: value) {
            let list = RealmSwift.List<T>()
            list.append(objectsIn: objects)
            return list
        }
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        return value?.compactMap { $0.toJSON() }
    }
    
}
