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
    public var owner: String?
    public var avatar: String?
    public var url: String?
    public var language: String?
    public var languageColor: String?
    public var des: String?
    public var stars: Int?
    public var forks: Int?
    public var currentPeriodStars: Int?
    public var builtBy = [User].init()
    // 扩展字段
    public var pageType: PageType?
    
    public init() { }
    
    public init?(map: ObjectMapper.Map) { }
    
    public mutating func mapping(map: ObjectMapper.Map) {
        id                  <- (map["id"], StringTransform.shared)
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
        builtBy             <- map["builtBy"]
        pageType            <- (map["pageType"], EnumTypeCastTransform<PageType>())
        if id.isEmpty {
            id = name ?? UUID().uuidString
        }
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.owner == rhs.owner &&
        lhs.avatar == rhs.avatar &&
        lhs.url == rhs.url &&
        lhs.language == rhs.language &&
        lhs.languageColor == rhs.languageColor &&
        lhs.des == rhs.des &&
        lhs.stars == rhs.stars &&
        lhs.forks == rhs.forks &&
        lhs.currentPeriodStars == rhs.currentPeriodStars &&
        lhs.builtBy == rhs.builtBy
    }
    
}
