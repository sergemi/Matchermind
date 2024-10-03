//
//  AuthService.swift
//  Matchermind
//
//  Created by sergemi on 02.10.2024.
//

//import Foundation
import Combine
import FirebaseAuth

struct User: Equatable, Identifiable {
    let id = UUID()
    let email: String
}

protocol AuthServiceProtocol: ObservableObject {
    var user: User? { get set }
    
    func logOut() throws
    
    func login(email: String, password: String) async throws
}

class AuthService: AuthServiceProtocol {
    @Published var user: User? = nil
    
    init() {
        // Подписываемся на изменения состояния аутентификации
        _ = Auth.auth().addStateDidChangeListener { [weak self] _, user in
//            self?.user = user?.email
            guard let userEmail = user?.email else {
                return
            }
            
            self?.user = User(email: userEmail)
        }
    }
    
    @MainActor func logOut() throws {
        try Auth.auth().signOut()
        user = nil
    }
    
    @MainActor func login(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
}

class MockAuthService: AuthServiceProtocol {
    @Published var user: User? = nil
    
    init(email: String? = nil) {
        guard let email = email else {
            return
        }
        user = User(email: email)
    }
    
    func logOut() throws {
        user = nil
    }
    
    func login(email: String, password: String) async throws {
        user = User(email: email)
    }
}
