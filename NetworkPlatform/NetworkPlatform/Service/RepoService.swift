//
//  RepoService.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/19.
//

import Foundation
import Combine
import Moya
import HiCore
import Domain

final class RepoService: Domain.RepoService {
    
    private let environment: [String: Any]

    init(environment: [String: Any]) {
        self.environment = environment
    }

    func repos() -> AnyPublisher<[Domain.Repo], any Error> {
        multiNetworking.requestArray(
            MultiTarget.init(
                TrendingAPI.repos
            ),
            type: Repo.self
        )
    }
    
    func save(repos: [Domain.Repo]) -> AnyPublisher<Void, any Error> {
        fatalError()
    }

}
