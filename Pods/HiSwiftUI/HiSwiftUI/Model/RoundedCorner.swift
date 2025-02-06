//
//  RoundedCorner.swift
//  Pods
//
//  Created by 杨建祥 on 2025/1/1.
//

import SwiftUI

public struct RoundedCorner: Shape {
    let radius: CGFloat
    let corners: UIRectCorner
    
    public init(radius: CGFloat, corners: UIRectCorner) {
        self.radius = radius
        self.corners = corners
    }

    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}


