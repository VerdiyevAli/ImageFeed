import Foundation

final class OAuth2TokenStorage {
    static let shared = OAuth2TokenStorage()
    private let authTokenKey = "accesToken"
    
    var token: String? {
        get {
            return UserDefaults.standard.string(forKey: authTokenKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: authTokenKey)
            
        }
    }
}
