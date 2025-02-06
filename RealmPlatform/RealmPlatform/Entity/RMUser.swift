//
//  RMUser.swift
//  RealmPlatform
//
//  Created by 杨建祥 on 2024/5/15.
//

import Foundation
import ObjectMapper
import RealmSwift
import Domain
import HiBase
import HiRealm

class RMUser: Object, Mappable {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var username: String?
    @Persisted var nickname: String?
    @Persisted var avatar: String?
    @Persisted var href: String?
    
    override init() {
        super.init()
    }
    
    required init?(map: ObjectMapper.Map) {
        super.init()
        id                  <- (map["id"], StringTransform.shared)
    }
    
    func mapping(map: ObjectMapper.Map) {
        performMapping {
            id              >>> map["id"]
            username        <- (map["username"], StringTransform.shared)
            nickname        <- (map["nickname"], StringTransform.shared)
            avatar          <- (map["avatar"], StringTransform.shared)
            href            <- (map["href"], StringTransform.shared)
        }
    }
    
    override class func propertiesMapping() -> [String: String] {
        [:]
    }
}

extension RMUser: DomainConvertibleType {
    func asDomain() -> Domain.User {
        .init(JSON: toJSON())!
    }
}

extension Domain.User: RealmRepresentable {
    internal var uid: String { self.id }
    
    func asRealm() -> RMUser {
        .init(JSON: toJSON())!
    }
}
