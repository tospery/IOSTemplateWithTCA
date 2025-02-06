//
//  ButtonModel.swift
//  Pods
//
//  Created by 杨建祥 on 2024/11/16.
//

import Foundation
import ObjectMapper
import HiBase
import HiCore

public enum HiButtonStyle: Int, Codable {
    case plain
    case round
}

public struct ButtonModel: ModelType {
    
    public var id = ""
    public var style = HiButtonStyle.plain
    public var height: Double?
    public var title: String?
    public var titleColor: String?
    public var backgroundColor: String?
    public var tintColor: String?
    public var enabled: Bool? = true
    public var target: String?

    public init() { }

    public init?(map: Map) { }
    
    public init(
        id: String = "button-\(UUID().uuidString)",
        style: HiButtonStyle = .plain,
        title: String? = nil,
        height: Double? = nil,
        titleColor: String? = nil,
        backgroundColor: String? = nil,
        tintColor: String? = nil,
        enabled: Bool? = true,
        target: String? = nil
    ) {
        self.id = id
        self.style = style
        self.enabled = enabled
        self.title = title
        self.height = height
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.target = target
    }

    mutating public  func mapping(map: Map) {
        id                  <- (map["id"], StringTransform.shared)
        style               <- (map["style"], EnumTypeCastTransform<HiButtonStyle>())
        enabled             <- (map["enabled"], BoolTransform.shared)
        height              <- (map["height"], DoubleTransform.shared)
        titleColor          <- (map["titleColor"], StringTransform.shared)
        backgroundColor     <- (map["backgroundColor"], StringTransform.shared)
        tintColor           <- (map["tintColor"], StringTransform.shared)
        title               <- (map["title"], StringTransform.shared)
        target              <- (map["target"], StringTransform.shared)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.style == rhs.style &&
        lhs.height == rhs.height &&
        lhs.titleColor == rhs.titleColor &&
        lhs.backgroundColor == rhs.backgroundColor &&
        lhs.tintColor == rhs.tintColor &&
        lhs.title == rhs.title &&
        lhs.target == rhs.target &&
        lhs.enabled == rhs.enabled
    }

}

