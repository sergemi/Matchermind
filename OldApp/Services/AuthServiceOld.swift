//
//  AuthService.swift
//  Matchermind
//
//  Created by sergemi on 02.10.2024.
//

import Foundation
import SwiftUI // TODO: maybe dont need
import FirebaseAuth

protocol AuthServiceProtocolOld: ObservableObject {
    var user: User? { get set }
    
    var userPublisher: Published<User?>.Publisher { get }
    
    func signOut() throws
    
    func signIn(email: String, password: String) async throws
    
    func signUp(email: String, password: String) async throws
}

class AuthServiceOld: AuthServiceProtocolOld {
    private var handle: AuthStateDidChangeListenerHandle?
    
    @Published var user: User? = nil
    
    var userPublisher: Published<User?>.Publisher { $user }
    
    init() {
        // Subscribe to firebase auth state changes
        handle = Auth.auth().addStateDidChangeListener { [weak self] _, firUser in
            guard let firUser = firUser else {
                return
            }
            
            self?.user = User(id: firUser.uid,
                              email: firUser.email ?? "")
        }
    }
    
    deinit {
        guard let handle = handle else {
            return
        }
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
        user = nil
    }
    
    @MainActor func signIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func signUp(email: String, password: String) async throws {
        try await Auth.auth().createUser(withEmail: email, password: password)
    }
}

class MockAuthServiceOld: AuthServiceProtocolOld {
    static let mocUserEmail = "mocUser@gmail.com"
    static let mocUserPassword = "mocUser"
    
    @Published var user: User? = nil
    var userPublisher: Published<User?>.Publisher { $user }
    
    private struct MockUser {
        var user: User
        var password: String
    }
    
    private var users: [String: MockUser] = [:]
    
    
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
    
    static func initWithMockUser(loginned: Bool = true) -> MockAuthServiceOld {
        let authService = MockAuthServiceOld(email: MockAuthServiceOld.mocUserEmail, password: MockAuthServiceOld.mocUserPassword, autoLogin: loginned)
        return authService
    }
    
    func signOut() throws {
//        users.removeValue(forKey: user?.id ?? "")
        user = nil
    }
    
    func signIn(email: String, password: String) async throws {
        // TODO: moc errors handle
        
        let signedUser = users.first(where: {$0.value.user.email == email} )
        guard let signedUser = signedUser else {
            return
        }
        user = signedUser.value.user
    }
    
    func signUp(email: String, password: String) async throws {
        // TODO: moc errors handle
        
        let newUser = User(id: UUID().uuidString,
                    email: email)
        
        user = newUser
        let mockUser = MockUser(user: newUser, password: password)
        users[newUser.id] = mockUser
    }

}
