//
//  TileCell.swift
//  Pods
//
//  Created by 杨建祥 on 2024/11/17.
//

import SwiftUI
import SwiftUIKit_Hi
import HiResource
import HiCore
import HiSwiftUI

public struct TileCell: View {

    let model: Tile
    let action: (() -> Void)?
    
    public init(_ model: Tile) {
        self.model = model
        self.action = nil
    }
    
    public init(_ model: Tile, action: @escaping () -> Void) {
        self.model = model
        self.action = action
    }
    
    public var body: some View {
        if model.isSpace {
            Rectangle()
                .fill(model.color?.swiftUIColor ?? Color.clear)
                .frame(maxWidth: .infinity)
                .frame(height: model.height ?? 12)
        } else {
            Button {
                action?()
            } label: {
                VStack(spacing: 0) {
                    Spacer()
                    HStack {
                        // icon
                        if model.icon?.isEmpty ?? true {
                            Spacer()
                                .frame(width: pixelOne)
                                .padding(.leading)
                        } else {
                            if model.icon!.hasSuffix("_icon"), let uiImage = UIImage(named: model.icon!) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(.leading)
                            } else {
                                Spacer()
                                    .frame(width: pixelOne)
                                    .padding(.leading)
                            }
                        }
                        // title
                        if model.title?.isEmpty ?? true {
                            EmptyView()
                        } else {
                            text()
                                .font(.system(size: 15))
                                .foregroundStyle(
                                    (model.disabled ?? false) ? Color.secondary : Color.primary.opacity(0.8)
                                )
                                .padding(.trailing, (model.style == .adjust ? (model.hasExtendInfo ? 0 : 30) : 0))
                        }
                        Spacer()
                        // detail
                        if model.detail?.isEmpty ?? true {
                            EmptyView()
                        } else {
                            Text(model.detail!)
                                .font(.system(size: 13))
                                .foregroundStyle(Color.secondary)
                        }
                        // indicator
                        if !(model.indicated ?? false) {
                            EmptyView()
                        } else {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14))
                                .foregroundStyle(Color.secondary.opacity(0.6))
                                .padding(.trailing)
                        }
                        // checked
                        if !(model.checked ?? false) {
                            EmptyView()
                        } else {
                            Image(systemName: "checkmark")
                                .font(.system(size: 14))
                                .foregroundStyle(Color.accentColor)
                                .padding(.trailing)
                        }
                    }
                    Spacer()
                    if model.separated ?? false {
                        Separator()
                            .padding(.leading)
                    } else {
                        EmptyView()
                    }
                }
            }
            .frame(height: model.height ?? 44)
            .background(Color.background)
        }
    }
    
    func text() -> Text {
        let string = model.title ?? ""
        if model.autoLinked ?? false {
            return Text(LocalizedStringKey(string))
        }
        let resource = LocalizedStringResource.init(stringLiteral: string)
        var text = AttributedString.init(localized: resource)
        text.font = .system(size: 15)
        if model.disabled ?? false {
            text.foregroundColor = .secondary
        } else {
            text.foregroundColor = .primary.opacity(0.8)
        }
        text.link = nil
        return Text(text)
    }
    
}
