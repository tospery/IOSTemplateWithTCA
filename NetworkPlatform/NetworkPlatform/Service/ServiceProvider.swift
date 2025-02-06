//
//  ServiceProvider.swift
//  NetworkPlatform
//
//  Created by 杨建祥 on 2024/5/17.
//

import Foundation
import Combine
import Domain

public final class ServiceProvider: Domain.ServiceProvider {
    
    private let environment: [String: Any]
    
    public init(environment: [String: Any] = [:]) {
        self.environment = environment
        NetworkPlatform.environment = environment
    }
    
    public func profileService() -> Domain.ProfileService {
        ProfileService(environment: environment)
    }
    
    public func repoService() -> Domain.RepoService {
        RepoService(environment: environment)
    }

    public func languageService() -> Domain.LanguageService {
        LanguageService(environment: environment)
    }
    
}
