import UIKit

protocol WaterTrackingDelegate {
    func drinkWater(amount: Float)
}

final class WaterTracker {
    var delegate: WaterTrackingDelegate?
    
    func drinkWater(amount: Float) {
        print("You drunk water!")
        delegate?.drinkWater(amount: amount)
    }
}

class GlassView {
    private var waterHeight: Float = 0
    private var waterTracker = WaterTracker()
    
    init() {
        waterTracker.delegate = self
    }
    
    func plusButtonTapped() {
        waterTracker.drinkWater(amount: 200)
    }
}

extension GlassView: WaterTrackingDelegate {
    func drinkWater(amount: Float) {
        waterHeight += amount
        print("Water height is increased: \(waterHeight)")
    }
}

let view = GlassView()
view.plusButtonTapped()
