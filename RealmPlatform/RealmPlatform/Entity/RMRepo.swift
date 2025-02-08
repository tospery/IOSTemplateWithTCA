//
//  RMRepo.swift
//  Pods
//
//  Created by 杨建祥 on 2025/1/18.
//

import Foundation
import ObjectMapper
import RealmSwift
import Domain
import HiBase
import HiRealm

class RMRepo: Object, Mappable {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String?
    @Persisted var fullName: String?
    @Persisted var url: String?
    @Persisted var nodeId: String?
    @Persisted var htmlUrl: String?
    @Persisted var language: String?
    @Persisted var des: String?
    @Persisted var `private`: Bool?
    @Persisted var fork: Bool?
    @Persisted var stargazersCount: Int?
    @Persisted var watchersCount: Int?
    @Persisted var forksCount: Int?
    @Persisted var owner: RMUser?
    @Persisted var pageType: RMPageType?
    
    override init() {
        super.init()
    }
    
    required init?(map: ObjectMapper.Map) {
        super.init()
        id                      <- (map["id"], StringTransform.shared)
    }
    
    func mapping(map: ObjectMapper.Map) {
        performMapping {
            id                  >>> map["id"]
            name                <- (map["name"], StringTransform.shared)
            fullName            <- (map["full_name"], StringTransform.shared)
            url                 <- (map["url"], StringTransform.shared)
            nodeId              <- (map["node_id"], StringTransform.shared)
            htmlUrl             <- (map["html_url"], StringTransform.shared)
            language            <- (map["language"], StringTransform.shared)
            des                 <- (map["description"], StringTransform.shared)
            `private`           <- (map["private"], BoolTransform.shared)
            fork                <- (map["fork"], BoolTransform.shared)
            stargazersCount     <- (map["stargazers_count"], IntTransform.shared)
            watchersCount       <- (map["watchers_count"], IntTransform.shared)
            forksCount          <- (map["forks_count"], IntTransform.shared)
            owner               <- map["owner"]
            pageType            <- (map["pageType"], EnumTypeCastTransform<RMPageType>())
        }
    }
    
    override class func propertiesMapping() -> [String: String] {
        [
            "fullName": "full_name",
            "nodeId": "node_id",
            "htmlUrl": "html_url",
            "stargazersCount": "stargazers_count",
            "watchersCount": "watchers_count",
            "forksCount": "forks_count"
        ]
    }

}

extension RMRepo: DomainConvertibleType {
    func asDomain() -> Repo {
        .init(JSON: toJSON())!
    }
}

extension Repo: RealmRepresentable {
    internal var uid: String { self.id }
    
    func asRealm() -> RMRepo {
        .init(JSON: toJSON())!
    }
}
