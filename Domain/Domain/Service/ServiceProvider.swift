//
//  ServiceProvider.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/12.
//

import Foundation
import HiBase

public protocol ServiceProvider: HiBase.ServiceProvider {
    
    func profileService() -> ProfileService
    func repoService() -> RepoService
    func languageService() -> LanguageService

}
