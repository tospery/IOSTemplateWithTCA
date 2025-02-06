//
//  ProfileService.swift
//  RealmPlatform
//
//  Created by 杨建祥 on 2024/5/13.
//

import Foundation
import Domain
import Combine
import RealmSwift

final class ProfileService<Repository>: Domain.ProfileService where Repository: AbstractRepository, Repository.T == Domain.Profile {
    
    private let repository: Repository

    init(repository: Repository) {
        self.repository = repository
    }
    
    func profile() -> AnyPublisher<Domain.Profile?, any Error> {
        repository.query(with: .init(format: "id == %@", "default"), sortDescriptors: []).map { $0.first }.eraseToAnyPublisher()
    }
    
    func save(profile: Domain.Profile) -> AnyPublisher<Void, any Error> {
        repository.save(entity: profile)
    }

}
