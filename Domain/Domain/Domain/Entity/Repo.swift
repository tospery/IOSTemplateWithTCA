//
//  Repo.swift
//  Pods
//
//  Created by 杨建祥 on 2025/1/29.
//

import Foundation
import ObjectMapper
import HiBase

public struct Repo: ModelType {
    
    public var id = ""
    public var name: String?
    public var fullName: String?
    public var url: String?
    public var nodeId: String?
    public var htmlUrl: String?
    public var language: String?
    public var des: String?
    public var `private`: Bool?
    public var fork: Bool?
    public var stargazersCount: Int?
    public var watchersCount: Int?
    public var forksCount: Int?
    public var owner: User?
    // 扩展字段
    public var pageType: PageType?
    
    public init() { }
    
    public init?(map: ObjectMapper.Map) { }
    
    public mutating func mapping(map: ObjectMapper.Map) {
        id                  <- (map["id"], StringTransform.shared)
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
        pageType            <- (map["pageType"], EnumTypeCastTransform<PageType>())
        if id.isEmpty {
            id = name ?? UUID().uuidString
        }
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.fullName == rhs.fullName &&
        lhs.url == rhs.url
    }
    
}
