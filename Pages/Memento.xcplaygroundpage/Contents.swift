import Foundation

typealias Memento = [String: String]

protocol CustomConvertibleObject {
    var memento: Memento { get }
}

public class WaterTracker: CustomConvertibleObject {
    var amountOfWaterDrunk: Double
    var username: String
    
    var memento: Memento {
        [Keys.amountOfWaterDrunk: "\(amountOfWaterDrunk)", Keys.username: username]
    }
    
    init(amountOfWaterDrunk: Double, username: String) {
        self.amountOfWaterDrunk = amountOfWaterDrunk
        self.username = username
    }
    
    init?(memento: Memento) {
        guard let amountOfWaterDrunk = memento[Keys.amountOfWaterDrunk],
              let username = memento[Keys.username] else { return nil }
        
        self.amountOfWaterDrunk = Double(amountOfWaterDrunk) ?? 0
        self.username = username
    }
}

extension WaterTracker {
    private enum Keys {
        static let amountOfWaterDrunk = "amountOfWaterDrunk"
        static let username = "username"
    }
}

enum CheckPoint {
    static func save(_ state: CustomConvertibleObject, forKey key: String) {
        UserDefaults.standard.set(state.memento, forKey: key)
    }
    
    static func restore(forKey key: String) -> Any? {
        UserDefaults.standard.object(forKey: key)
    }
}

// Usage
let tracker = WaterTracker(amountOfWaterDrunk: 200, username: "Yaman")
tracker.amountOfWaterDrunk += 150
CheckPoint.save(tracker, forKey: "waterTrackState1")

tracker.amountOfWaterDrunk += 300
CheckPoint.save(tracker, forKey: "waterTrackState2")

if let memento1 = CheckPoint.restore(forKey: "waterTrackState1") as? Memento,
   let state1 = WaterTracker(memento: memento1) {
    print(state1.amountOfWaterDrunk)
}

if let memento2 = CheckPoint.restore(forKey: "waterTrackState2") as? Memento,
   let state2 = WaterTracker(memento: memento2) {
    print(state2.amountOfWaterDrunk)
}

