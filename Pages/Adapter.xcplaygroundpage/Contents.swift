import Foundation

// MARK: - Custom Enums
enum EventName: String {
    case homeButtonTapped = "homeButtonTapped"
    case backButtonTapped = "backButtonTapped"
}

enum EventParameters: String {
    case isGuest = "isGuest"
}

// MARK: - SDKs
class FirebaseAnalytics {
    func logEvent(_ name: String, parameters: [String : Any]) {
        // Send event to firebase servers
        print("Saved in Firebase")
    }
}

class InsiderAnalytics {
    func logEvent(_ name: String, parameters: [String : Any]) {
        // Send event to insider servers
        print("Saved in Insider")
    }
}

// MARK: - Required Adapter Protocol
protocol EventLog {
    func log(event: EventName, parameters: [EventParameters : Any])
}

// MARK: - Adapter
struct EventManager: EventLog {
    private let firebaseAnalytics = FirebaseAnalytics()
    private let insiderAnalytics = InsiderAnalytics()
    
    func log(event: EventName, parameters: [EventParameters : Any]) {
        firebaseAnalytics.logEvent(event.rawValue, parameters: getParameters(parameters))
        insiderAnalytics.logEvent(event.rawValue, parameters: getParameters(parameters))
    }
    
    private func getParameters(_ parameters: [EventParameters : Any]) -> [String: Any] {
        var newParameters = [String : Any]()
        for parameter in parameters {
            newParameters[parameter.key.rawValue] = parameter.value
        }
        return newParameters
    }
}

// MARK: - Usage

func homeButtonTapped() {
    let eventManager = EventManager()
    eventManager.log(event: .homeButtonTapped, parameters: [.isGuest : true])
}

homeButtonTapped()
