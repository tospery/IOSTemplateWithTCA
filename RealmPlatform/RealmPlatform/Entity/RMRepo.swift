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
    @Persisted var owner: String?
    @Persisted var avatar: String?
    @Persisted var url: String?
    @Persisted var language: String?
    @Persisted var languageColor: String?
    @Persisted var des: String?
    @Persisted var stars: Int?
    @Persisted var forks: Int?
    @Persisted var currentPeriodStars: Int?
    @Persisted var builtBy: RealmSwift.List<RMUser>
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
            owner               <- (map["owner"], StringTransform.shared)
            avatar              <- (map["avatar"], StringTransform.shared)
            url                 <- (map["url"], StringTransform.shared)
            language            <- (map["language"], StringTransform.shared)
            languageColor       <- (map["languageColor"], StringTransform.shared)
            des                 <- (map["description"], StringTransform.shared)
            stars               <- (map["stars"], IntTransform.shared)
            forks               <- (map["forks"], IntTransform.shared)
            currentPeriodStars  <- (map["currentPeriodStars"], IntTransform.shared)
            builtBy             <- (map["builtBy"], RealmListTransform<RMUser>())
            pageType            <- (map["pageType"], EnumTypeCastTransform<RMPageType>())
        }
    }
    
    override class func propertiesMapping() -> [String: String] {
        [
            "des": "description"
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
