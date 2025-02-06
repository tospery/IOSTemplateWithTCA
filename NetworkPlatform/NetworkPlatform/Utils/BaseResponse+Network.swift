//
//  BaseResponse+Network.swift
//  NetworkPlatform
//
//  Created by 杨建祥 on 2024/5/18.
//

import Foundation
import Moya
import ObjectMapper
import HiCore
import HiBase
import HiNet

extension BaseResponse: @retroactive ResponseCompatible {
    
    public func code(map: Map) -> Int {
        var code: Int?
        code        <- (map["code"], IntTransform.shared)
        code = code == nil ? -1 : code
        return code == 0 ? ErrorCode.ok : code!
    }
    
    public func message(map: Map) -> String? {
        var message: String?
        message     <- (map["message"], StringTransform.shared)
        if message == nil {
            message <- (map["msg"], StringTransform.shared)
        }
        return message
    }
    
    public func data(map: Map) -> Any? {
        var data: Any?
        data        <- map["data"]
        return data
    }
    
    public func code(_ target: TargetType) -> Int {
        return self.code
    }
    
    public func message(_ target: TargetType) -> String? {
        return self.message
    }
    
    public func data(_ target: TargetType) -> Any? {
        return self.data
    }

}
