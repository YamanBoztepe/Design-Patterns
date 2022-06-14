
import Foundation

struct TargetDetails {
    let targetedDays: Int
    let currentDate: Int
    
    var isCompleted: Bool {
        currentDate == targetedDays || currentDate > targetedDays
    }
}

protocol QuitBadHabit {
    var habitName: String { get }
    func getMotivation(accordingTo target: TargetDetails) -> String
}

final class Smoking: QuitBadHabit {
    let habitName = "Smoking"
    
    func getMotivation(accordingTo target: TargetDetails) -> String {
        let isSucceedText = target.isCompleted ? "completed" : " will complete"
        return "You \(isSucceedText) to quit \(habitName)"
    }
}

final class Alcohol: QuitBadHabit {
    let habitName = "Alcohol"
    
    func getMotivation(accordingTo target: TargetDetails) -> String {
        let isSucceedText = target.isCompleted ? "handled" : " will handle"
        return "You \(isSucceedText) to quit \(habitName)"
    }
}

struct User {
    let userId = UUID()
    let name: String
    let badHabit: QuitBadHabit
    let target: TargetDetails
}

class QuitBadHabitService {
    static func sendMessage(to user: User) {
        let message = "Hi \(user.name), \(user.badHabit.getMotivation(accordingTo: user.target))"
        print(message)
    }
}

let user1 = User(
    name: "Yaman",
    badHabit: Smoking(),
    target: TargetDetails(
        targetedDays: 12,
        currentDate: 12
    )
)

let user2 = User(
    name: "Mehmet",
    badHabit: Alcohol(),
    target: TargetDetails(
        targetedDays: 12,
        currentDate: 8
    )
)

QuitBadHabitService.sendMessage(to: user1)
QuitBadHabitService.sendMessage(to: user2)
