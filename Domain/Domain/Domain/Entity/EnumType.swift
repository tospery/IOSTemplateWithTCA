//
//  EnumType.swift
//  Pods
//
//  Created by 杨建祥 on 2025/2/6.
//

import Foundation

/// 用于列表所在的页面，比如用户列表可能在收藏页、也有可能在关注列表页，以用户中的pageType属性来区分
public enum PageType: String, Identifiable, Codable, Hashable {
    case none
    // 展示repo list的页面
    case dashboard, favorite
    
    public var id: String { rawValue }
}
