//
//  ServiceProvider.swift
//  RealmPlatform
//
//  Created by 杨建祥 on 2024/5/13.
//

import Foundation
import Domain
import RealmSwift

public final class ServiceProvider: Domain.ServiceProvider {
    
    private let configuration: Realm.Configuration

    public init(configuration: Realm.Configuration = .defaultConfiguration) {
        self.configuration = configuration
    }
    
    public func repoService() -> Domain.RepoService {
        RepoService(repository: Repository<Domain.Repo>(configuration: configuration))
    }
    
    public func profileService() -> Domain.ProfileService {
        ProfileService(repository: Repository<Domain.Profile>(configuration: configuration))
    }
    
    public func languageService() -> Domain.LanguageService {
        LanguageService(repository: Repository<Domain.Language>(configuration: configuration))
    }

}

