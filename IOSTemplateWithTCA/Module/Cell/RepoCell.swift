//
//  RepoCell.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2024/11/17.
//

import SwiftUI
import Kingfisher
import HiBase
import HiCore
import HiLog
import HiSwiftUI
import Domain

struct RepoCell: View {
    let model: Repo
    let action: (String) -> Void
    
    init(_ model: Repo, action: @escaping (String) -> Void) {
        self.model = model
        self.action = action
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                KFImage.url(model.owner?.avatar?.url)
                    .placeholder {
                        R.image.default_square_icon.swiftUIImage
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    .resizable()
                    .roundCorner(radius: .heightFraction(0.12))
                    .serialize(as: .PNG)
                    .loadDiskFileSynchronously()
                    .frame(width: 40, height: 40)
                    .padding(.trailing, 4)
                VStack(alignment: .leading, spacing: 4) {
                    Text(model.fullName ?? "")
                        .font(.system(size: 16, weight: .semibold))
                        .lineLimit(2)
                    HStack(spacing: 4) {
                        HStack(spacing: 4) {
                            Circle()
                                .fill(model.language?.hashColor.swiftUIColor ?? Color.accentColor)
                                .frame(width: 10, height: 10)
                            Text(model.language ?? R.string.localizable.unknown.localizedString)
                                .font(.system(size: 11, weight: .medium))
                                .foregroundStyle(Color.primary.opacity(0.8))
                        }
                        .frame(width: screenWidth / 3.2, alignment: .leading)
                        HStack(spacing: 4) {
                            Text(UInt64(model.stargazersCount ?? 0).formatted)
                                .font(.system(size: 11, weight: .medium))
                                .foregroundStyle(Color.primary.opacity(0.8))
                        }
                        Spacer()
                        HStack(spacing: 4) {
                            Text(UInt64(model.forksCount ?? 0).formatted)
                                .font(.system(size: 11, weight: .medium))
                                .foregroundStyle(Color.primary.opacity(0.8))
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
            Text(model.des ?? "未提供描述")
                .font(.system(size: 15))
                .lineSpacing(2)
                .lineLimit(4)
                .multilineTextAlignment(.leading)
                .foregroundStyle(Color.primary.opacity(0.8))
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
        }
        .background(Color.background)
        .onTapGesture {
            action(model.htmlUrl ?? "")
        }
    }
}
