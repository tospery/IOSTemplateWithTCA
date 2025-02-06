import Foundation
import HiBase

/// 导航的分类
public enum JumpType: Int {
    /// 前进
    case forward
    /// 后退
    case back
}

/// 前进的分类 -> HiUIKit://[host]?forwardType=0
public enum ForwardType: Int {
    /// 推进
    case push
    /// 展示
    case present
    /// 打开
    case open
}

/// 后退的分类 -> HiUIKit://back?backType=0
public enum BackType: Int {
    /// 自动
    case auto
    /// 弹出（一个）
    case popOne
    /// 弹出（所有）
    case popAll
    /// 退场
    case dismiss
}

/// 打开的分类 -> HiUIKit://[popup|sheet|alert|toast]/[path]
public enum OpenType: Int {
    /// 消息框（自动关闭）
    case toast
    /// 提示框（可选择的）
    case alert
    /// 表单框（可操作的）
    case sheet
    /// 弹窗
    case popup
    /// 业务（自定义的首页或登录页等）
    case logic
    
    static let allHosts = [
        HiNavHost.toast,
        HiNavHost.alert,
        HiNavHost.sheet,
        HiNavHost.popup,
        HiNavHost.logic
    ]
}

public enum HiNavError: Error {
    case navigation
}

public typealias HiNavHost = String
public typealias HiNavPath = String

extension HiNavHost {
    /// 返回上一级（包括退回或者关闭）
    public static var back: HiNavHost { "back" }
    /// 弹窗分为两类（自动关闭的toast和手动关闭的）
    public static var toast: HiNavHost { "toast" }
    public static var alert: HiNavHost { "alert" }
    public static var sheet: HiNavHost { "sheet" }
    public static var popup: HiNavHost { "popup" }
    public static var logic: HiNavHost { "logic" }
    /// 常用host
    public static var web: HiNavHost { "web" }
    public static var user: HiNavHost { "user" }
    public static var home: HiNavHost { "home" }
    public static var login: HiNavHost { "login" }
    public static var personal: HiNavHost { "personal" }
}

extension HiNavPath { }


public protocol HiNavCompatible {
    
    // 合法的外部跳转
    func isLegalHost(host: HiNavHost) -> Bool
    func allowedPaths(host: HiNavHost) -> [HiNavPath]
    
    // user-login
    func isLogined() -> Bool
    func needLogin(host: HiNavHost, path: HiNavPath?) -> Bool
    
    // target解析
    func resolution(_ target: String) -> Any?
    
}

final public class HiNav {
    
    public static var shared = HiNav()
    
    init() { }
    
    public func deepLink(host: HiNavHost, path: HiNavPath? = nil, parameters: [String: String]? = nil) -> String {
        var url = "\(Bundle.main.urlScheme() ?? "")://\(host)".url!
        if let path = path {
            url.appendPathComponent(path)
        }
        if let parameters = parameters {
            url.appendQueryParameters(parameters)
        }
        return url.absoluteString.removingSuffix("?")
    }
    
    public func parse(_ target: String) -> Any? {
        if let compatible = self as? HiNavCompatible {
            return compatible.resolution(target)
        }
        return nil
    }
    
    // MARK: - back
    public func backDeepLink(_ type: BackType? = nil) -> String {
        var parameters = [String: String].init()
        if type != nil {
            parameters[Parameter.type] = type!.rawValue.string
        }
        return deepLink(host: .back, parameters: parameters)
    }
    
    // MARK: - toast
    public func toastActivityDeepLink(_ active: Bool) -> String {
        deepLink(host: .toast, parameters: [
            Parameter.active: active.string
        ])
    }
    
    public func toastMessageDeepLink(_ message: String, active: Bool? = nil) -> String {
        deepLink(host: .toast, parameters: [
            Parameter.message: message
        ])
    }
    
    // MARK: - alert
    public func alertDeepLink(_ title: String, _ message: String, _ actions: [AlertActionType]) -> String {
        var parameters = [String: String].init()
        if title.isNotEmpty {
            parameters[Parameter.title] = title
        }
        if message.isNotEmpty {
            parameters[Parameter.message] = message
        }
        let stringArray = actions.map { $0.description }.filter { $0.isNotEmpty }
        let jsonString = jsonString(with: stringArray) ?? ""
        if jsonString.isNotEmpty {
            parameters[Parameter.actions] = jsonString
        }
        return deepLink(host: .alert, parameters: parameters)
    }
    
    // MARK: - sheet
    public func sheetDeepLink(_ title: String, _ message: String, _ actions: [AlertActionType]) -> String {
        var parameters = [String: String].init()
        if title.isNotEmpty {
            parameters[Parameter.title] = title
        }
        if message.isNotEmpty {
            parameters[Parameter.message] = message
        }
        let stringArray = actions.map { $0.description }.filter { $0.isNotEmpty }
        let jsonString = jsonString(with: stringArray) ?? ""
        if jsonString.isNotEmpty {
            parameters[Parameter.actions] = jsonString
        }
        return deepLink(host: .sheet, parameters: parameters)
    }
    
    // MARK: - popup
    public func popupDeepLink(_ type: String, _ data: String?) -> String {
        var parameters = [String: String].init()
        if type.isNotEmpty {
            parameters[Parameter.type] = type
        }
        if data?.isNotEmpty ?? false {
            parameters[Parameter.data] = data!
        }
        return deepLink(host: .popup, parameters: parameters)
    }
    
    // MARK: - logic
    public func logicDeepLink(_ type: String, _ data: String?) -> String {
        var parameters = [String: String].init()
        if type.isNotEmpty {
            parameters[Parameter.type] = type
        }
        if data?.isNotEmpty ?? false {
            parameters[Parameter.data] = data!
        }
        return deepLink(host: .logic, parameters: parameters)
    }
    
    // MARK: - login
    public func checkNeedLogin(_ target: String) -> Bool {
        guard let url = target.url else { return false }
        guard let host = url.host() else { return false }
        var needLogin = false
        if let compatible = self as? HiNavCompatible {
            if compatible.needLogin(host: host, path: url.path()) {
                needLogin = true
            }
        }
        return needLogin
    }

    // MARK: - login
    private func jsonString(with array: [String], prettify: Bool = false) -> String? {
        guard JSONSerialization.isValidJSONObject(array) else { return nil }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        guard let jsonData = try? JSONSerialization.data(withJSONObject: array, options: options) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
    
}
