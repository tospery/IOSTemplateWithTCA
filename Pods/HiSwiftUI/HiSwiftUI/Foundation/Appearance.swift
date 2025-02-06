//
//  Appearance.swift
//  HiSwiftUI
//
//  Created by 杨建祥 on 2024/10/15.
//

import Foundation
import UIKit
import HiCore
import SwiftUI

public protocol AppearanceCompatible {
    func myConfig()
}

final public class Appearance {
    
    public static var shared = Appearance()
    
    public init() {
    }
    
    @discardableResult
    public func config() {
        if let compatible = self as? AppearanceCompatible {
            compatible.myConfig()
        } else {
            self.basic()
        }
    }
    
    public func basic() {
        let color = profileService.value?.accentColor.color ?? .blue
        // Window
        UIWindow.appearance().tintColor = color
        // NavBar
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = Color.container.uiColor
        let barButtonItemAppearance = UIBarButtonItemAppearance()
        barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        navigationBarAppearance.buttonAppearance = barButtonItemAppearance
        navigationBarAppearance.backButtonAppearance = barButtonItemAppearance
        let backIndicatorImage = UIImage.back.withTintColor(.label, renderingMode: .alwaysOriginal)
        navigationBarAppearance.setBackIndicatorImage(backIndicatorImage, transitionMaskImage: backIndicatorImage)
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        
        // TabBar
        let tabBarAppearance = UITabBarAppearance.init()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = Color.container.uiColor
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.iconColor = Color.secondary.uiColor
        tabBarItemAppearance.normal.titleTextAttributes = [.foregroundColor: Color.secondary.uiColor]
        tabBarItemAppearance.selected.iconColor = color
        tabBarItemAppearance.selected.titleTextAttributes = [.foregroundColor: color]
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        // TableView
        // UITableView.appearance().sectionHeaderTopPadding = 0
        // UITableView.appearance().rowHeight = 20
        // UITableView.appearance().separatorColor = UIColor.orange
    }
    
}
