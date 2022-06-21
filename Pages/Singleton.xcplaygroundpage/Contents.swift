import Foundation

struct DefaultsKey {
    static let isLoggedIn = "isLoggedIn"
}

final class SessionManager {
    static let shared = SessionManager()
    
    private init() { }
    
    var isLoggedIn: Bool {
        get { UserDefaults.standard.bool(forKey: DefaultsKey.isLoggedIn) }
        set { UserDefaults.standard.set(newValue, forKey: DefaultsKey.isLoggedIn) }
    }
}

class LogOutButton {
    func logOut() {
        SessionManager.shared.isLoggedIn = false
    }
}

class LogInButton {
    func logIn() {
        SessionManager.shared.isLoggedIn = true
    }
}

let logInButton = LogInButton()
let logOutButton = LogOutButton()

print(SessionManager.shared.isLoggedIn)

logInButton.logIn()
print(SessionManager.shared.isLoggedIn)

logOutButton.logOut()
print(SessionManager.shared.isLoggedIn)

logInButton.logIn()
print(SessionManager.shared.isLoggedIn)

