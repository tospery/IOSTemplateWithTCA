//
//  DatabaseManager.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2025/2/6.
//

import Foundation
import Combine
import RealmSwift
import HiSwiftUI

class DatabaseManager {
    
    static var shared = DatabaseManager()
    
    func exampleData() -> AnyPublisher<Void, Error> {
        Future { promise in
            if Realm.fileExists(for: .defaultConfiguration) {
                promise(.success(()))
                return
            }
            let url = self.seedRealmUrl(for: schemaVersion)
            if FileManager.default.fileExists(atPath: url.path) {
                // swiftlint:disable force_try
                try! FileManager.default.removeItem(at: url)
                // swiftlint:enable force_try
            }
            let configuration = Realm.Configuration(fileURL: url, schemaVersion: UInt64(schemaVersion))
            IOSTemplateWithTCA.exampleData(configuration)
                .sink { completion in
                    switch completion {
                    case .finished:
                        promise(.success(()))
                    case let .failure(error):
                        promise(.failure(error))
                    }
                } receiveValue: { _ in}
                .store(in: &disposeBag)
        }
        .eraseToAnyPublisher()
    }
    
    func performMigration() -> AnyPublisher<Void, Error> {
        Future { promise in
            if schemaVersion == 0 {
                if Realm.fileExists(for: .defaultConfiguration) {
                    promise(.success(()))
                    return
                }
                let bundleRealmUrl = self.bundleRealmUrl(for: schemaVersion)
                let defaultRealmUrl = Realm.Configuration.defaultConfiguration.fileURL!
                // swiftlint:disable force_try
                try! FileManager.default.copyItem(at: bundleRealmUrl, to: defaultRealmUrl)
                // swiftlint:enable force_try
                IOSTemplateWithTCA.migrationCheck(.defaultConfiguration)
                    .sink { completion in
                        switch completion {
                        case .finished:
                            promise(.success(()))
                        case let .failure(error):
                            promise(.failure(error))
                        }
                    } receiveValue: { _ in }
                    .store(in: &disposeBag)
            } else {
                // 数据升级处理
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func seedRealmUrl(for schemaVersion: Int) -> URL {
        let defaultURL = Realm.Configuration.defaultConfiguration.fileURL!
        let defaultParentURL = defaultURL.deletingLastPathComponent()
        let fileName = "default-v\(schemaVersion)"
        let destinationUrl = defaultParentURL.appendingPathComponent(fileName + ".realm")
        return destinationUrl
    }
    
    func bundleRealmUrl(for schemaVersion: Int) -> URL {
        let fileName = "default-v\(schemaVersion)"
        let bundleUrl = Bundle.main.url(forResource: fileName, withExtension: "realm")!
        return bundleUrl
    }
    
}
