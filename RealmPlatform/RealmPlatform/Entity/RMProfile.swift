//
//  RMProfile.swift
//  RealmPlatform
//
//  Created by 杨建祥 on 2024/5/12.
//

import Foundation
import ObjectMapper
import RealmSwift
import Domain
import HiBase
import HiRealm

final class RMProfile: Object, Mappable {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var isDark: Bool?
    @Persisted var localization: RMLocalization?
    @Persisted var user: RMUser?
    
    override init() {
        super.init()
    }
    
    init?(map: ObjectMapper.Map) {
        super.init()
        id                          <- (map["id"], StringTransform.shared)
    }
    
    func mapping(map: ObjectMapper.Map) {
        performMapping {
            id                      >>> map["id"]
            isDark                  <- (map["isDark"], BoolTransform.shared)
            localization            <- (map["localization"], EnumTypeCastTransform<RMLocalization>())
            user                    <- map["user"]
        }
    }
    
    override class func propertiesMapping() -> [String: String] {
        [:]
    }
}

extension RMProfile: DomainConvertibleType {
    func asDomain() -> Profile {
        .init(JSON: toJSON())!
    }
}

extension Profile: RealmRepresentable {
    internal var uid: String { self.id }
    
    func asRealm() -> RMProfile {
        .init(JSON: toJSON())!
    }
    
}

