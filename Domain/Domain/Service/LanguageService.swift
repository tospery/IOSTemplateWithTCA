//
//  LanguageService.swift
//  Pods
//
//  Created by 杨建祥 on 2025/2/6.
//

import Foundation
import Combine

public protocol LanguageService {

    func languages() -> AnyPublisher<[Language], Error>
    func save(languages: [Language]) -> AnyPublisher<Void, Error>

}
