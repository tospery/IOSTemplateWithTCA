//
//  RepoService.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/19.
//

import Foundation
import Combine

public protocol RepoService {

    func repos() -> AnyPublisher<[Repo], Error>
    func save(repos: [Repo]) -> AnyPublisher<Void, Error>

}

