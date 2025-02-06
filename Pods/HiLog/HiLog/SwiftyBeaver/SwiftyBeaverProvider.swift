import Foundation
import SwiftyBeaver

private let sbLogger = SwiftyBeaver.self

final public class SwiftyBeaverProvider: ProviderType {
    
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd HH:mm:ss"
        return formatter
    }()
    
    public init() {
        sbLogger.addDestination(ConsoleDestination.init())
        sbLogger.addDestination(FileDestination.init())
    }
    
    public func log(_ message: @autoclosure () -> Any, module: String, level: Level, file: String, line: Int, function: String, context: Any?) {
        sbLogger.custom(
            level: .init(rawValue: level.rawValue) ?? .debug,
            message: "【\(module)】\(message())",
            file: file,
            function: function,
            line: line,
            context: context
        )
    }

}
