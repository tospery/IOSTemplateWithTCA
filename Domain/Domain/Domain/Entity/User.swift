//
//  User.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/15.
//

import Foundation
import ObjectMapper
import HiBase

public struct User: UserType {
    
    public var id = ""
    public var username: String?
    public var nickname: String?
    public var avatar: String?
    public var href: String?

    public var isValid: Bool { (!id.isEmpty) && !(username?.isEmpty ?? true) }

    public init() { }
    
    public init?(map: ObjectMapper.Map) { }
    
    public mutating func mapping(map: ObjectMapper.Map) {
        id              <- (map["id"], StringTransform.shared)
        username        <- (map["username"], StringTransform.shared)
        nickname        <- (map["name"], StringTransform.shared)
        avatar          <- (map["avatar"], StringTransform.shared)
        href             <- (map["href"], StringTransform.shared)
        if id.isEmpty {
            id = username ?? UUID().uuidString
        }
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.username == rhs.username &&
        lhs.nickname == rhs.nickname &&
        lhs.avatar == rhs.avatar &&
        lhs.href == rhs.href
    }

}
