//
//  RMEnumType.swift
//  Pods
//
//  Created by 杨建祥 on 2025/2/6.
//

import Foundation
import RealmSwift
import HiBase
import Domain

// MARK: - RMPageType
enum RMPageType: String, Codable, PersistableEnum {
    case none
    case dashboard
}

extension RMPageType: DomainConvertibleType {
    func asDomain() -> PageType {
        .init(rawValue: self.rawValue)!
    }
}

extension PageType: RealmRepresentable {
    internal var uid: String { self.id }
    
    func asRealm() -> RMPageType {
        .init(rawValue: self.rawValue)!
    }
}

// MARK: - RMLocalization
enum RMLocalization: String, Codable, PersistableEnum {
    case chinese    = "zh-Hans"
    case english    = "en"
    
    public static let allValues = [chinese, english]
}

extension RMLocalization: DomainConvertibleType {
    func asDomain() -> Localization {
        .init(rawValue: self.rawValue)!
    }
}

extension Localization: RealmRepresentable {
    internal var uid: String { self.rawValue }
    
    func asRealm() -> RMLocalization {
        .init(rawValue: self.rawValue)!
    }
}
