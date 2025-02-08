//
//  GithubAPI.swift
//  Pods
//
//  Created by 杨建祥 on 2025/2/8.
//

import Foundation
import SwifterSwift
import Moya
import HiBase
import HiCore
import Domain

enum GithubAPI {
    case search(keyword: String, pageIndex: Int, pageSize: Int)
}

extension GithubAPI: TargetType {

    var baseURL: URL { "https://api.github.com".url! }

    var path: String {
        switch self {
        case .search: return "/search/repositories"
        }
    }

    var method: Moya.Method { .get }

    var headers: [String: String]? { nil }

    var task: Task {
        var parameters = NetworkPlatform.environment
        let encoding: ParameterEncoding = URLEncoding.default
        switch self {
        case let .search(keyword, pageIndex, pageSize):
            parameters[Parameter.searchKey] = keyword
            parameters[Parameter.pageIndex] = pageIndex
            parameters[Parameter.pageSize] = pageSize
        }
        return .requestParameters(parameters: parameters, encoding: encoding)
    }

    var validationType: ValidationType { .none }

    var sampleData: Data { Data.init() }

}
