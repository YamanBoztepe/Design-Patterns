import Foundation

class Monster {
    let level: Int
    let damage: Double
    var health: Double = 100
    
    init(level: Int, damage: Double) {
        self.level = level
        self.damage = damage
    }
    
    func clone() -> Monster {
        Monster(level: level, damage: damage)
    }
}

// MARK: - Usage
let prototype = Monster(level: 12, damage: 30)

let monster1 = prototype.clone()
monster1.health = 40

let monster2 = prototype.clone()
monster1.health = 10

let monster3 = prototype.clone()
monster1.health = 0


// Memory addresses are also different
print(Unmanaged.passUnretained(monster1).toOpaque())
print(Unmanaged.passUnretained(monster2).toOpaque())
print(Unmanaged.passUnretained(monster3).toOpaque())
