//
//  FirebaseAuthService.swift
//  MyRouter
//
//  Created by sergemi on 06/05/2025.
//

import Foundation
import FirebaseAuth

actor FirebaseAuthService: AuthServiceProtocol {
    var user: User?
    
    private var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        // Subscribe to firebase auth state changes
        handle = Auth.auth().addStateDidChangeListener { [weak self] _, firUser in
            guard let firUser = firUser else {
                return
            }
            
            Task {
                await self?.setUser(from: firUser)
            }
        }
    }
    
    deinit {
        guard let handle = handle else {
            return
        }
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    private func setUser(from firUser: FirebaseAuth.User) async {
        self.user = User(
            id: firUser.uid,
            email: firUser.email ?? ""
        )
    }
    
    
    func signIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func signUp(email: String, password: String) async throws {
        try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
        user = nil
    }
}
