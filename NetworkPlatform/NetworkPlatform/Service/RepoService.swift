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

    func search(keyword: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.Repo], any Error> {
        multiNetworking.requestList(
            MultiTarget.init(
                GithubAPI.search(keyword: keyword, pageIndex: pageIndex, pageSize: pageSize)
            ),
            type: Repo.self
        ).map { $0.items }.eraseToAnyPublisher()
    }

}
