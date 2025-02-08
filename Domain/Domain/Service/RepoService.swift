//
//  RepoService.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/19.
//

import Foundation
import Combine

public protocol RepoService {

    func search(keyword: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.Repo], any Error>

}

