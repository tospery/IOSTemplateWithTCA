//
//  default-v0.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2024/10/15.
//

// #if REALM_SCHEMA_VERSION_0

import Foundation
import Combine
import RealmSwift
import RealmPlatform
import Domain
import HiCore

let schemaVersion = 0

let migrationBlock: MigrationBlock = { _, _ in }

func migrationCheck(_ configuration: Realm.Configuration) -> AnyPublisher<Void, Error> {
    let provider: Domain.ServiceProvider = RealmPlatform.ServiceProvider(configuration: configuration)
    return Publishers.CombineLatest(
        provider.languageService().languages(),
        provider.profileService().profile()
    ).tryMap { languages, profile in
        guard languages.count == 472 else { throw IOSTemplateWithTCA.APPError.databaseSeedFailed }
        guard profile?.isValid ?? false else { throw IOSTemplateWithTCA.APPError.databaseSeedFailed }
        return ()
    }.eraseToAnyPublisher()
}

func exampleData(_ configuration: Realm.Configuration) -> AnyPublisher<Void, Error> {
    let provider: Domain.ServiceProvider = RealmPlatform.ServiceProvider(configuration: configuration)
    // swiftlint:disable force_try
    let languages = try! [Language].init(
        JSONString: String(
            contentsOfFile: Bundle.main.path(forResource: "LanguageList", ofType: "json")!,
            encoding: .utf8
        )
    )!
    // swiftlint:enable force_try
    let languagesPublisher = provider.languageService().save(languages: languages)
        .map { _ in () }
        .eraseToAnyPublisher()
    let profilePublisher = provider.profileService().save(profile: .default)
        .map { _ in () }
        .eraseToAnyPublisher()
    return languagesPublisher
        .append(profilePublisher)
        .eraseToAnyPublisher()
}

// #endif
