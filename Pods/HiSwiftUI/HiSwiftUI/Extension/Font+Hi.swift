//
//  Font+Hi.swift
//  Pods
//
//  Created by 杨建祥 on 2024/11/24.
//

import SwiftUI
import UIKit
import SwifterSwift

/// 客户化的字体采用scale方法来实现
public extension Font {
    
    var uiFont: UIFont? {
        switch self {
        case .largeTitle: return .preferredFont(forTextStyle: .largeTitle)
        case .title: return .preferredFont(forTextStyle: .title1)
        case .title2: return .preferredFont(forTextStyle: .title2)
        case .title3: return .preferredFont(forTextStyle: .title3)
        case .headline: return .preferredFont(forTextStyle: .headline)
        case .subheadline: return .preferredFont(forTextStyle: .subheadline)
        case .body: return .preferredFont(forTextStyle: .body)
        case .callout: return .preferredFont(forTextStyle: .callout)
        case .footnote: return .preferredFont(forTextStyle: .footnote)
        case .caption: return .preferredFont(forTextStyle: .caption1)
        case .caption2: return .preferredFont(forTextStyle: .caption2)
        default: return nil
        }
    }
    
    func scale(_ scale: Double) -> Font {
        guard let size = self.uiFont?.pointSize.double else { return self }
        return .system(size: size * scale)
    }
    
}


public extension UIFont {
    
}
