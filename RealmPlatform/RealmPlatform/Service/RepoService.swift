//
//  RepoService.swift
//  RealmPlatform
//
//  Created by 杨建祥 on 2024/5/20.
//

import Foundation
import Domain
import Combine
import RealmSwift

final class RepoService<Repository>: Domain.RepoService where Repository: AbstractRepository, Repository.T == Domain.Repo {
    
    private let repository: Repository

    init(repository: Repository) {
        self.repository = repository
    }
    
    func repos() -> AnyPublisher<[Domain.Repo], any Error> {
        repository.query(with: nil, sortDescriptors: [])
    }

    func save(repos: [Domain.Repo]) -> AnyPublisher<Void, any Error> {
        repository.save(entities: repos)
    }
    
}
