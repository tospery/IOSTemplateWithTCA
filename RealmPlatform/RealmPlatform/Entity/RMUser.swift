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
    @Persisted var url: String?
    @Persisted var type: String?
    @Persisted var nodeId: String?
    @Persisted var htmlUrl: String?
    @Persisted var pageType: RMPageType?
    
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
            username        <- (map["login"], StringTransform.shared)
            nickname        <- (map["name"], StringTransform.shared)
            avatar          <- (map["avatar_url"], StringTransform.shared)
            url             <- (map["url"], StringTransform.shared)
            type            <- (map["type"], StringTransform.shared)
            nodeId          <- (map["node_id"], StringTransform.shared)
            htmlUrl         <- (map["html_url"], StringTransform.shared)
            pageType        <- (map["pageType"], EnumTypeCastTransform<RMPageType>())
        }
    }
    
    override class func propertiesMapping() -> [String: String] {
        [
            "avatar": "avatar_url",
            "nodeId": "node_id",
            "htmlUrl": "html_url"
        ]
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
