//
//  TrendingAPI.swift
//  Pods
//
//  Created by 杨建祥 on 2025/1/19.
//

import Foundation
import SwifterSwift
import Moya
import HiBase
import HiCore
import Domain

enum TrendingAPI {
    case repos
}

extension TrendingAPI: TargetType {

    var baseURL: URL { "https://gtrend.yapie.me".url! }

    var path: String {
        switch self {
        case .repos: return "/repositories"
        }
    }

    var method: Moya.Method { .get }

    var headers: [String: String]? { nil }

    var task: Task {
        var parameters = NetworkPlatform.environment
        let encoding: ParameterEncoding = URLEncoding.default
        switch self {
        case .repos:
            parameters[Parameter.since] = "weekly"
        }
        return .requestParameters(parameters: parameters, encoding: encoding)
    }

    var validationType: ValidationType { .none }

    var sampleData: Data { Data.init() }

}
