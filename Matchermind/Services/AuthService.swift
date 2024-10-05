//
//  AuthService.swift
//  Matchermind
//
//  Created by sergemi on 02.10.2024.
//

import Foundation
import SwiftUI // TODO: maybe dont need
import FirebaseAuth

struct User: Equatable, Identifiable {
    let id: String
    let email: String
}

protocol AuthServiceProtocol: ObservableObject {
    var user: User? { get set }
    
    var userPublisher: Published<User?>.Publisher { get }
    
    func signOut() throws
    
    func signIn(email: String, password: String) async throws
}

class AuthService: AuthServiceProtocol {
    @Published var user: User? = nil
    
    var userPublisher: Published<User?>.Publisher { $user }
    
    init() {
        // Subscribe to firebase auth state changes
        _ = Auth.auth().addStateDidChangeListener { [weak self] _, firUser in
            guard let firUser = firUser else {
                return
            }
            
            self?.user = User(id: firUser.uid,
                              email: firUser.email ?? "")
        }
    }
    
    @MainActor func signOut() throws {
        try Auth.auth().signOut()
        user = nil
    }
    
    @MainActor func signIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
}

class MockAuthService: AuthServiceProtocol {
    @Published var user: User? = nil
    
    var userPublisher: Published<User?>.Publisher { $user }
    
    init(email: String? = nil) {
        guard let email = email else {
            return
        }
        user = User(id: UUID().uuidString,
                    email: email)
    }
    
    init() {
    }
    
    func signOut() throws {
        user = nil
    }
    
    func signIn(email: String, password: String) async throws {
        user = User(id: UUID().uuidString,
                    email: email)
    }
}
