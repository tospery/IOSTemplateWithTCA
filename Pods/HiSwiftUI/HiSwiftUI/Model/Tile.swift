//
//  Tile.swift
//  HiSwiftUI
//
//  Created by liaoya on 2022/9/23.
//

import Foundation
import ObjectMapper
import HiBase
import HiCore

public enum HiTileStyle: Int, Codable {
    case plain
    case adjust
    case space
}

public struct Tile: ModelType {
    
    public var id = ""
    public var style = HiTileStyle.plain
    public var separated: Bool? = true
    public var indicated: Bool? = false
    public var checked: Bool? = false
    public var autoLinked: Bool? = true
    public var disabled: Bool? = false
    public var height: Double?
    public var icon: String?
    public var title: String?
    public var detail: String?
    public var color: String?
    public var tintColor: String?
    public var target: String?
    
    public var isSpace: Bool { style == .space }

    public var hasExtendInfo: Bool {
        if (detail?.isEmpty ?? true) && !(indicated ?? false) && !(checked ?? false) {
            return false
        }
        return true
    }
    
    public init() { }

    public init?(map: Map) { }
    
    public init(
        id: String = "",
        style: HiTileStyle = .plain,
        icon: String? = nil,
        title: String? = nil,
        detail: String? = nil,
        separated: Bool? = true,
        indicated: Bool? = false,
        checked: Bool? = false,
        autoLinked: Bool? = true,
        disabled: Bool? = false,
        height: Double? = nil,
        color: String? = nil,
        tintColor: String? = nil,
        target: String? = nil
    ) {
        self.id = id
        self.style = style
        self.icon = icon
        self.title = title
        self.detail = detail
        self.indicated = indicated
        self.separated = separated
        self.checked = checked
        self.autoLinked = autoLinked
        self.disabled = disabled
        self.height = height
        self.color = color
        self.tintColor = tintColor
        self.target = target
    }

    mutating public  func mapping(map: Map) {
        id              <- (map["id"], StringTransform.shared)
        style           <- (map["style"], EnumTypeCastTransform<HiTileStyle>())
        height          <- (map["height"], DoubleTransform.shared)
        color           <- (map["color"], StringTransform.shared)
        tintColor       <- (map["tintColor"], StringTransform.shared)
        icon            <- (map["icon"], StringTransform.shared)
        title           <- (map["title"], StringTransform.shared)
        detail          <- (map["detail"], StringTransform.shared)
        indicated       <- (map["indicated"], BoolTransform.shared)
        separated       <- (map["separated"], BoolTransform.shared)
        checked         <- (map["checked"], BoolTransform.shared)
        autoLinked      <- (map["autoLinked"], BoolTransform.shared)
        disabled        <- (map["disabled"], BoolTransform.shared)
        target          <- (map["target"], StringTransform.shared)
    }
    
    public func copyWith(id: String) -> Tile {
        var myTile = self
        myTile.id = id
        return myTile
    }
    
    public func copyWith(title: String?) -> Tile {
        var myTile = self
        myTile.title = title
        return myTile
    }
    
    public func copyWith(detail: String?) -> Tile {
        var myTile = self
        myTile.detail = detail
        return myTile
    }
    
    public func copyWith(target: String?) -> Tile {
        var myTile = self
        myTile.target = target
        return myTile
    }
    
    public func copyWith(checked: Bool?) -> Tile {
        var myTile = self
        myTile.checked = checked
        return myTile
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.style == rhs.style &&
        lhs.height == rhs.height &&
        lhs.color == rhs.color &&
        lhs.tintColor == rhs.tintColor &&
        lhs.icon == rhs.icon &&
        lhs.title == rhs.title &&
        lhs.detail == rhs.detail &&
        lhs.indicated == rhs.indicated &&
        lhs.separated == rhs.separated &&
        lhs.checked == rhs.checked &&
        lhs.autoLinked == rhs.autoLinked &&
        lhs.target == rhs.target
    }

    public static func space(
        height: Double? = nil,
        color: String? = nil
    ) -> Tile {
        .init(
            id: "space-\(UUID().uuidString)",
            style: .space,
            height: height,
            color: color
        )
    }
    
}

