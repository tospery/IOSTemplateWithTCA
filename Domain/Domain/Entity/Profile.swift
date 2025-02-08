//
//  Profile.swift
//  Pods
//
//  Created by 杨建祥 on 2025/2/5.
//

import Foundation
import ObjectMapper
import HiBase

public struct Profile: ProfileType {
    
    public var id = ""
    public var isDark: Bool?
    public var localization: Localization?
    public var user: User?
    
    public var accentColor: String { UIColor.orange.hexString }
    
    public var loginedUser: (any HiBase.UserType)? {
        get { return user }
        set { user = newValue as? User }
    }
    
    public static let `default` = Profile.init(JSON: [ "id": "default" ])!
    
    public init() { }
    
    public init?(map: ObjectMapper.Map) { }
    
    public mutating func mapping(map: ObjectMapper.Map) {
        id                  <- (map["id"], StringTransform.shared)
        isDark              <- (map["isDark"], BoolTransform.shared)
        localization        <- (map["localization"], EnumTypeCastTransform<Localization>())
        user                <- map["user"]
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.isDark == rhs.isDark &&
        lhs.localization == rhs.localization &&
        lhs.user == rhs.user
    }

}
