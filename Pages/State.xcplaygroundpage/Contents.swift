import Foundation

class AuthContext {
    private var authState: AuthState = UnauthorizedState()
    
    var isAuthorized: Bool {
        get { return authState.isAuthorized(context: self) }
    }
    
    var userId: String? {
        get { return authState.userId(context: self) }
    }
    
    func changeStateToAuthorized(userId: String) {
        authState = AuthorizedState(userId: userId)
    }
    
    func changeStateToUnauthorized() {
        authState = UnauthorizedState()
    }
}

protocol AuthState {
    func isAuthorized(context: AuthContext) -> Bool
    func userId(context: AuthContext) -> String?
}

class UnauthorizedState: AuthState {
    func isAuthorized(context: AuthContext) -> Bool { return false }
    func userId(context: AuthContext) -> String? { return nil }
}

class AuthorizedState: AuthState {
    let userId: String

    init(userId: String) { self.userId = userId }
    
    func isAuthorized(context: AuthContext) -> Bool { return true }
    func userId(context: AuthContext) -> String? { return userId }
}
