import Foundation

// MARK: - Factory
protocol FitnessProgram {
    var numberOfReps: Int { get }
    var isLightWeight: Bool { get }
}

final class Kids: FitnessProgram {
    var numberOfReps: Int {
        120
    }
    
    var isLightWeight: Bool {
        true
    }
}

final class Adults: FitnessProgram {
    var numberOfReps: Int {
        200
    }
    
    var isLightWeight: Bool {
        false
    }
}

enum CustomerCategory {
    case kids
    case adults
}

enum FitnessProgramFactory {
    static func createFitnessProgram(for customer: CustomerCategory) -> FitnessProgram {
        switch customer {
        case .kids:
            return Kids()
        case .adults:
            return Adults()
        }
    }
}

print(FitnessProgramFactory.createFitnessProgram(for: .kids).numberOfReps)
print(FitnessProgramFactory.createFitnessProgram(for: .adults).numberOfReps)


// MARK: - Abstract Factory
protocol FitnessProgram2 {
    var numberOfReps: Int { get }
    var isLightWeight: Bool { get }
}

struct BeginnerProgram: FitnessProgram2 {
    var numberOfReps: Int
    var isLightWeight: Bool
}

protocol FitnessProgramCreating {
    func create() -> FitnessProgram2
}

final class Kids2: FitnessProgramCreating {
    func create() -> FitnessProgram2 {
        BeginnerProgram(numberOfReps: 120, isLightWeight: true)
    }
}

final class Adults2: FitnessProgramCreating {
    func create() -> FitnessProgram2 {
        BeginnerProgram(numberOfReps: 200, isLightWeight: false)
    }
}

enum FitnessProgramFactory2: FitnessProgramCreating {
    case kids
    case adults
    
    func create() -> FitnessProgram2 {
        switch self {
        case .kids:
            return Kids2().create()
        case .adults:
            return Adults2().create()
        }
    }
}

print(FitnessProgramFactory2.kids.create())
print(FitnessProgramFactory2.adults.create())
