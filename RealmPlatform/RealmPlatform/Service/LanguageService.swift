//
//  LanguageService.swift
//  Pods
//
//  Created by 杨建祥 on 2025/2/6.
//

import Foundation
import Domain
import Combine
import RealmSwift

final class LanguageService<Repository>: Domain.LanguageService where Repository: AbstractRepository, Repository.T == Language {
    
    private let repository: Repository

    init(repository: Repository) {
        self.repository = repository
    }
    
    func languages() -> AnyPublisher<[Domain.Language], any Error> {
        repository.query(with: nil, sortDescriptors: [])
    }
    
    func save(languages: [Domain.Language]) -> AnyPublisher<Void, any Error> {
        repository.save(entities: languages)
    }
    
}
