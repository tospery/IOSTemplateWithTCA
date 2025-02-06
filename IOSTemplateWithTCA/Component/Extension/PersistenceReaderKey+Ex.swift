//
//  InMemoryKey+Ex.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2024/11/17.
//

import Foundation
import ComposableArchitecture
import HiBase
import Domain

extension PersistenceReaderKey where Self == FileStorageKey<Domain.Profile> {
    static var profile: Self {
        fileStorage(.documentsDirectory.appending(component: "profile.json"))
    }
}
