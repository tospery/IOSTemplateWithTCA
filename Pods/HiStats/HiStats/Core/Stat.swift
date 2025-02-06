public protocol AnalyticsType {
    associatedtype Event: EventType
    func register(provider: ProviderType)
    func stats(_ event: Event)
}

public protocol ProviderType {
    func stats(_ eventName: String, parameters: [String: Any]?)
}

public protocol EventType {
    func name(for provider: ProviderType) -> String?
    func parameters(for provider: ProviderType) -> [String: Any]?
}

open class Analytics<Event: EventType>: AnalyticsType {
    private(set) open var providers: [ProviderType] = []
    
    public init() {
        // I'm Analytics 👋
    }
    
    open func register(provider: ProviderType) {
        self.providers.append(provider)
    }
    
    open func stats(_ event: Event) {
        for provider in self.providers {
            guard let eventName = event.name(for: provider) else { continue }
            let parameters = event.parameters(for: provider)
            provider.stats(eventName, parameters: parameters)
        }
    }
}
