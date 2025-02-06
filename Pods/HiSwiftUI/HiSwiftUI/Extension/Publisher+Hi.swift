//
//  Publisher.swift
//  Pods
//
//  Created by 杨建祥 on 2024/10/16.
//

import SwiftUI
import Combine
import HiCore

public var disposeBag = Set<AnyCancellable>.init()

public extension Publisher {

//    func async() async throws -> Output {
//        try await withCheckedThrowingContinuation { continuation in
//            var finishedWithoutValue = true
//            var cancellable: AnyCancellable?
//            cancellable = self
//                .sink { completion in
//                    cancellable?.cancel()
//                    switch completion {
//                    case .finished:
//                        if finishedWithoutValue {
//                            continuation.resume(throwing: HiError.unknown)
//                        }
//                    case let .failure(error):
//                        continuation.resume(throwing: error)
//                    }
//                } receiveValue: { value in
//                    cancellable?.cancel()
//                    finishedWithoutValue = false
//                    continuation.resume(returning: value)
//                }
//            cancellable?.store(in: &disposeBag)
//        }
//    }

    func asResult() async -> Result<Output, Error> {
        do {
            for try await value in self.values {
                return .success(value)
            }
        } catch {
            return .failure(error)
        }
        return .failure(HiError.unknown)
    }
    
    func asOutput() async -> Output? {
        do {
            for try await value in self.values {
                return value
            }
        } catch {
            return nil
        }
        return nil
    }
    
    func asError() async -> Error? {
        do {
            for try await value in self.values {
                return nil
            }
        } catch {
            return error
        }
        return nil
    }
    
    func asStream() -> AsyncThrowingStream<Output, Error> {
        AsyncThrowingStream<Output, Error> { continuation in
            self.sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    continuation.finish()
                case .failure(let error):
                    continuation.finish(throwing: error)
                }
            }, receiveValue: { value in
                continuation.yield(value)
            }).store(in: &disposeBag)
        }
    }
    
//    static func fromAsync<T>(_ tasks: [() async -> T]) async -> AnyPublisher<T, Error> {
//        await withCheckedContinuation { continuation in
//            await withTaskGroup(of: T.self) { group in
//                for task in tasks {
//                    group.addTask {
//                        await task()
//                    }
//                }
//                
//                for await result in group {
//                    continuation.resume(returning: result)
//                }
//            }
//        }
//    }

    //                    let stream = AsyncThrowingStream<Domain.QWen, Error> { continuation in
    //                        self.platformClient.network().qwenService().qwen(content: content)
    //                            .sink(
    //                                receiveCompletion: { completion in
    //                                    switch completion {
    //                                    case .finished:
    //                                        continuation.finish()
    //                                    case .failure(let error):
    //                                        continuation.finish(throwing: error)
    //                                    }
    //                                },
    //                                receiveValue: { value in
    //                                    continuation.yield(value)
    //                                }
    //                            ).store(in: &disposeBag)
    //                    }
    
//    func wait(matching targetValue: Output) async -> Output? where Output: Equatable {
//        await withCheckedContinuation { continuation in
//            var cancellable: AnyCancellable?
//            cancellable = self
//                .filter { $0 == targetValue }
//                .first()
//                .sink(receiveCompletion: { completion in
//                    switch completion {
//                    case .finished:
//                        continuation.resume(returning: nil)
//                    case .failure:
//                        continuation.resume(returning: nil)
//                    }
//                    cancellable?.cancel()
//                }, receiveValue: { value in
//                    continuation.resume(returning: value)
//                    cancellable = nil
//                })
//        }
//    }
    
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

