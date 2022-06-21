import Foundation

protocol ObserverActions {
    func willSet(newValue: Any)
    func didSet(oldValue: Any)
}

class BaseViewModel {
    var observer: ObserverActions?
}

final class WaterTracker: BaseViewModel {
    var amountOfWaterDrunk = 0.0 {
        willSet { observer?.willSet(newValue: newValue) }
        didSet { observer?.didSet(oldValue: oldValue) }
    }
}

final class Observer: ObserverActions {
    private var willChange: ((_ newValue: Any) -> Void)? = nil
    private var didChange: ((_ oldValue: Any) -> Void)? = nil
    
    func willSet(newValue: Any) {
        willChange?(newValue)
    }
    
    func didSet(oldValue: Any) {
        didChange?(oldValue)
    }
    
    func sink(
        willChange: ((_ newValue: Any) -> Void)? = nil,
        didChange: ((_ oldValue: Any) -> Void)? = nil
    ) {
        self.willChange = willChange
        self.didChange = didChange
    }
}

var observer = Observer()
var tracker = WaterTracker()

tracker.observer = observer
observer.sink { newValue in
  print("Value will be \(newValue)")
    
} didChange: { oldValue in
    print("Value was \(oldValue)")
}

tracker.amountOfWaterDrunk = 200
tracker.amountOfWaterDrunk += 1
tracker.amountOfWaterDrunk -= 40

tracker.observer = nil
tracker.amountOfWaterDrunk = 150
