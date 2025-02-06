//
//  Appdata.swift
//  Pods
//
//  Created by 杨建祥 on 2024/11/27.
//

import Foundation
import Combine
import HiBase

public let profileService = CurrentValueSubject<(any ProfileType)?, Never>(nil)

final public class Appdata {
    
    public static var shared = Appdata()
    
    public init() {
    }
    
    public func inject(_ profile: any ProfileType) {
        profileService.send(profile)
    }
    
}
