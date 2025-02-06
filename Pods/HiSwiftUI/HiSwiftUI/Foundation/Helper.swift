//
//  Helper.swift
//  HiSwiftUI
//
//  Created by 杨建祥 on 2024/10/14.
//

import SwiftUI
import Combine
import HiBase
import HiCore
import HiLog

public func logEnvironment() {
    log("本地目录: \(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.path ?? "")", module: Module.hiSwiftUI)
    log("信息设置: \(profileService.value!)", module: Module.hiSwiftUI)
    log("运行环境: \(UIApplication.shared.inferredEnvironment)", module: Module.hiSwiftUI)
    log("设备型号: \(UIDevice.current.modelName)", module: Module.hiSwiftUI)
    log("硬件标识: \(UIDevice.current.uuid)", module: Module.hiSwiftUI)
    log("系统名称: \(UIDevice.current.systemName)", module: Module.hiSwiftUI)
    log("系统版本: \(UIDevice.current.systemVersion)", module: Module.hiSwiftUI)
    log("应用标识: \(UIApplication.shared.bundleIdentifier)", module: Module.hiSwiftUI)
    log("应用版本: \(UIApplication.shared.version)", module: Module.hiSwiftUI)
    log("网页地址: \(UIApplication.shared.baseWebUrl)", module: Module.hiSwiftUI)
    log("服务地址: \(UIApplication.shared.baseApiUrl)", module: Module.hiSwiftUI)
    log("通用链接: \(UIApplication.shared.baseUnivLink)", module: Module.hiSwiftUI)
    log("屏幕尺寸: \(UIScreen.main.bounds.size)", module: Module.hiSwiftUI)
    log("安全区域: \(safeArea)", module: Module.hiSwiftUI)
    log("状态栏(\(statusBarHeightConstant))|导航栏(\(navigationBarHeight))|标签栏(\(tabBarHeight))", module: Module.hiSwiftUI)
}

public func convertToResult<Output>(
    publisher: AnyPublisher<Output, Error>,
    completion: @escaping (Result<Output, any Error>) -> Void
) -> AnyCancellable {
    publisher
        .sink { state in
            switch state {
            case let .failure(error):
                completion(.failure(error))
            case .finished:
                break
            }
        } receiveValue: { value in
            completion(.success(value))
        }
}

//public extension AnyPublisher {
//    func async(cancellables: inout Set<AnyCancellable>) async throws -> Output {
//        try await withCheckedThrowingContinuation { continuation in
//            self.sink(
//                receiveCompletion: { completion in
//                    switch completion {
//                    case .finished:
//                        break
//                    case let .failure(error):
//                        continuation.resume(throwing: error)
//                    }
//                },
//                receiveValue: { value in
//                    continuation.resume(returning: value)
//                }
//            )
//            .store(in: &cancellables)
//        }
//    }
//}
