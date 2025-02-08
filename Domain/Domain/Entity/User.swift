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
    public var url: String?
    public var type: String?
    public var nodeId: String?
    public var htmlUrl: String?
    // 扩展字段
    public var pageType: PageType?

    public var isValid: Bool { (!id.isEmpty) && !(username?.isEmpty ?? true) }

    public init() { }
    
    public init?(map: ObjectMapper.Map) { }
    
    public mutating func mapping(map: ObjectMapper.Map) {
        id                  <- (map["id"], StringTransform.shared)
        username            <- (map["login"], StringTransform.shared)
        nickname            <- (map["name"], StringTransform.shared)
        avatar              <- (map["avatar_url"], StringTransform.shared)
        url                 <- (map["url"], StringTransform.shared)
        type                <- (map["type"], StringTransform.shared)
        nodeId              <- (map["node_id"], StringTransform.shared)
        htmlUrl             <- (map["html_url"], StringTransform.shared)
        pageType            <- (map["pageType"], EnumTypeCastTransform<PageType>())
        if id.isEmpty {
            id = username ?? UUID().uuidString
        }
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.username == rhs.username
    }

}
