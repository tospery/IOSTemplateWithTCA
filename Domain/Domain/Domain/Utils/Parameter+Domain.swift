//
//  Parameter+Domain.swift
//  NetworkPlatform
//
//  Created by 杨建祥 on 2024/5/19.
//

import Foundation
import HiBase

public extension Parameter {
    static var osType: String { "os_type" }
    static var osVersion: String { "os_version" }
    static var deviceModel: String { "device_model" }
    static var deviceId: String { "device_id" }
    static var appId: String { "app_id" }
    static var appVersion: String { "app_version" }
    static var appChannel: String { "app_channel" }
    static var pageIndex: String { "page" }
    static var pageSize: String { "per_page" }
    static var since: String { "since" }
}
