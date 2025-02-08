//
//  ProfileService.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/12.
//

import Foundation
import Combine

public protocol ProfileService {

    func profile() -> AnyPublisher<Profile?, Error>
    func save(profile: Profile) -> AnyPublisher<Void, Error>

}
