//
//  DataType.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2024/7/2.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import SwifterSwift
import HiBase
import HiNav
import HiSwiftUI

enum TileId: String, Hashable, Identifiable, CustomStringConvertible, CaseIterable {
    case space
    case blog, about
    case logo, toast, alert, sheet, popup, logic
    
    static let unloginValues = [space, blog, about]
    static let aboutValues = [logo, toast, alert, sheet, popup, logic]
    
    var id: String {
        if self == .space {
            return "space-\(UUID().uuidString)"
        }
        return rawValue
    }
    
    var separated: Bool {
        switch self {
        case .about, .logo, .logic:
            return false
        default:
            return true
        }
    }
    
    var indicated: Bool {
        true
    }
    
    public var description: String {
        self.rawValue.capitalizedFirstCharacter.localizedString
    }
    
    var icon: String {
        "\(self.rawValue)_icon"
    }
    
    var target: String? {
        switch self {
        case .space, .logo, .toast, .alert, .sheet, .popup, .logic: return nil
        case .blog: return "https://blog.csdn.net/tospery"
        default: return HiNav.shared.deepLink(host: self.rawValue.lowercased())
        }
    }

}

@CasePathable
enum ITAlertAction: AlertActionType, Identifiable, Equatable {
    case destructive
    case `default`
    case cancel
    case exit
    
    var id: String { description }
    
    init?(string: String) {
        if [
            R.string.localizable.oK.key.description.englishLocalizedString.lowercased(),
            R.string.localizable.oK.key.description.chineseLocalizedString.lowercased()
        ].contains(string.lowercased()) {
            self = .destructive
        } else if [
            R.string.localizable.sure.key.description.englishLocalizedString.lowercased(),
            R.string.localizable.sure.key.description.chineseLocalizedString.lowercased()
        ].contains(string.lowercased()) {
            self = .default
        } else if [
            R.string.localizable.cancel.key.description.englishLocalizedString.lowercased(),
            R.string.localizable.cancel.key.description.chineseLocalizedString.lowercased()
        ].contains(string.lowercased()) {
            self = .cancel
        } else if [
            R.string.localizable.exit.key.description.englishLocalizedString.lowercased(),
            R.string.localizable.exit.key.description.chineseLocalizedString.lowercased()
        ].contains(string.lowercased()) {
            self = .exit
        } else {
            return nil
        }
    }

    var description: String {
        switch self {
        case .destructive:  return R.string.localizable.oK.localizedString
        case .default:  return R.string.localizable.sure.localizedString
        case .cancel: return R.string.localizable.cancel.localizedString
        case .exit: return R.string.localizable.exit.localizedString
        }
    }

    var style: UIAlertAction.Style {
        switch self {
        case .cancel:  return .cancel
        default: return .destructive
        }
    }
    
    var role: ButtonStateRole? {
        switch self.style {
        case .destructive: return .destructive
        case .cancel: return .cancel
        default: return nil
        }
    }

    static func == (lhs: ITAlertAction, rhs: ITAlertAction) -> Bool {
        switch (lhs, rhs) {
        case (.destructive, .destructive),
            (.default, .default),
            (.cancel, .cancel),
            (.exit, .exit):
            return true
        default:
            return false
        }
    }
}

enum PopupType: String, CaseIterable {
    case share
}

enum LogicType: String, CaseIterable {
    case contact
}

enum TabBarItemType: Int, CaseIterable, Identifiable {
    case dashboard, favorite, personal
    var id: Int { rawValue }
    
    var title: String {
        switch self {
        case .dashboard: return R.string.localizable.dashboard.localizedKeyString
        case .favorite: return R.string.localizable.favorite.localizedKeyString
        case .personal: return R.string.localizable.personal.localizedKeyString
        }
    }
    var normalImage: Image {
        switch self {
        case .dashboard: return R.image.dashboard_normal_icon.swiftUIImage
        case .favorite: return R.image.favorite_normal_icon.swiftUIImage
        case .personal: return R.image.personal_normal_icon.swiftUIImage
        }
    }
    var selectedImage: Image {
        switch self {
        case .dashboard: return R.image.dashboard_selected_icon.swiftUIImage
        case .favorite: return R.image.favorite_selected_icon.swiftUIImage
        case .personal: return R.image.personal_selected_icon.swiftUIImage
        }
    }
}
