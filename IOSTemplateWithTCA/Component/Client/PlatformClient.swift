//
//  PlatformClient.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2024/9/21.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import Domain
import NetworkPlatform
import RealmPlatform

@DependencyClient
struct PlatformClient {
    
    var network: @Sendable () async -> Domain.ServiceProvider = {
        NetworkPlatform.ServiceProvider(environment: environment)
    }
    var database: @Sendable () async -> Domain.ServiceProvider = {
        RealmPlatform.ServiceProvider(configuration: .defaultConfiguration)
    }

}

extension PlatformClient: DependencyKey {
    static var liveValue: Self {
        .init()
    }
}

extension DependencyValues {
    var platformClient: PlatformClient {
        get { self[PlatformClient.self] }
        set { self[PlatformClient.self] = newValue }
    }
}
