//
//  MockAuthService.swift
//  MyRouter
//
//  Created by sergemi on 05/05/2025.
//

import Foundation

actor MockAuthService: AuthServiceProtocol {
    static let mocUserEmail = "mocUser@gmail.com"
    static let mocUserPassword = "mocUser"
    
    private static let mocUser = User(id: UUID().uuidString, email: mocUserEmail)
    private var users: [String: MockUser] = [:]
    
    var user: User?
    
    init(email: String?, password: String, autoLogin: Bool = false) {
        guard let email = email else {
            return
        }
        
        let newUser = User(id: UUID().uuidString,
                           email: email)
        
        let mockUser = MockUser(user: newUser, password: password)
        users[newUser.id] = mockUser
        
        if autoLogin {
            user = newUser
        }
    }
    
    static func initWithMockUser(loginned: Bool = true) -> MockAuthService {
        let authService = MockAuthService(email: MockAuthService.mocUserEmail, password: MockAuthService.mocUserPassword, autoLogin: loginned)
        return authService
    }
    
    func signIn(email: String, password: String) async throws {
        let signedUser = users.first(where: {$0.value.user.email == email} )
        guard let signedUser = signedUser else {
            return
        }
        user = signedUser.value.user
        
//        throw testError()
    }
    
    func signUp(email: String, password: String) async throws {
        let newUser = User(id: UUID().uuidString,
                    email: email)
        
        user = newUser
        let mockUser = MockUser(user: newUser, password: password)
        users[newUser.id] = mockUser
    }
    
    func signOut() throws {
        user = nil
    }
    
    func continueWithGoogle() async throws {
        print("TODO: continueWithGoogle")
    }
    
    func updateUserPhotoURL(url: URL, onSuccess: @escaping () -> Void) async throws {
        onSuccess()
    }
}

extension MockAuthService {
    private struct MockUser {
        var user: User
        var password: String
    }
}
