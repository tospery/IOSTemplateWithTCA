//
//  ProfileService.swift
//  NetworkPlatform
//
//  Created by 杨建祥 on 2024/5/22.
//

import Foundation
import Combine
import Moya
import HiCore
import Domain

final class ProfileService: Domain.ProfileService {

    private let environment: [String: Any]

    init(environment: [String: Any]) {
        self.environment = environment
    }

    func profile() -> AnyPublisher<Domain.Profile?, any Error> {
        Just(NetworkPlatform.profile).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func save(profile: Domain.Profile) -> AnyPublisher<Void, any Error> {
        NetworkPlatform.profile = profile
        return Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
}

