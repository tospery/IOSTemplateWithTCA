//
//  ObjectMapper+Realm.swift
//  HiUIKit
//
//  Created by 杨建祥 on 2024/5/13.
//

import Foundation
import ObjectMapper
import RealmSwift
import HiBase

public func <- <T: RealmCollectionValue & Mappable>(left: RealmSwift.List<T>, right: ObjectMapper.Map) {
    if right.mappingType == .toJSON {
        Array(left) >>> right
    } else if right.mappingType == .fromJSON {
        if right.isKeyPresent {
            var objects: [T]?
            objects <- right
            
            if let objects {
                if !left.isEmpty {
                    left.removeAll()
                }
                left.append(objectsIn: objects)
                
            } else {
                left.removeAll()
            }
        }
    }
}

public func <- <T: RealmCollectionValue>(left: RealmSwift.List<T>, right: ObjectMapper.Map) {
    if right.mappingType == .toJSON {
        Array(left) >>> right
        
    } else if right.mappingType == .fromJSON {
        if right.isKeyPresent {
            var objects: [T]?
            objects <- (right, TypeCastTransform<T>())
            
            if let objects {
                if !left.isEmpty {
                    left.removeAll()
                }
                left.append(objectsIn: objects)
                
            } else {
                left.removeAll()
            }
        }
    }
}

public func <- <T: RealmCollectionValue, Transform: TransformType>(left: RealmSwift.List<T>, right: (ObjectMapper.Map, Transform)) where T == Transform.Object {
    let map = right.0
    if map.mappingType == .toJSON {
        Array(left) >>> right
        
    } else if map.mappingType == .fromJSON {
        if map.isKeyPresent {
            var objects: [T]?
            objects <- right
            
            if let objects {
                if !left.isEmpty {
                    left.removeAll()
                }
                left.append(objectsIn: objects)
                
            } else {
                left.removeAll()
            }
        }
    }
}

public func <- <T: RealmCollectionValue>(left: RealmProperty<T?>, right: ObjectMapper.Map) {
    if right.mappingType == .toJSON {
        left.value >>> right
        
    } else if right.mappingType == .fromJSON {
        if right.isKeyPresent {
            var value: T?
            value <- (right, TypeCastTransform<T>())
            left.value = value
        }
    }
}

public func <- <T: RealmCollectionValue, Transform: TransformType>(left: RealmProperty<T?>, right: (ObjectMapper.Map, Transform)) where T == Transform.Object {
    let map = right.0
    let transform = right.1
    if map.mappingType == .toJSON {
        left.value >>> map
        
    } else if map.mappingType == .fromJSON {
        if map.isKeyPresent {
            let value = transform.transformFromJSON(map.currentValue)
            left.value = value
        }
    }
}
