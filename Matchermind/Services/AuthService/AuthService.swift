//
//  AuthService.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import Foundation

protocol AuthServiceProtocol: Actor {
    var user: User? { get }
    func signIn(email: String, password: String) async throws
    func signUp(email: String, password: String) async throws
    func signOut() throws
    func continueWithGoogle() async throws
    
    func updateUserPhotoURL(url: URL, onSuccess: @escaping () -> Void) async throws
}

@MainActor
@Observable
final class AuthService {
    var user: User?
    var userAvatarVersion: Int = 0 // For update avatar image with the same filename
    
    var service: AuthServiceProtocol
    
    init(service: AuthServiceProtocol) {
        self.service = service
        Task {
            user = await self.service.user
        }
    }
    
    func signIn(email: String, password: String) async throws {
        try await service.signIn(email: email, password: password)
        user = await service.user
    }
    
    func signUp(email: String, password: String) async throws {
        try await service.signUp(email: email, password: password)
        user = await service.user
    }
    
    func signOut() async throws {
        try await service.signOut()
        user = nil
    }
    
    func continueWithGoogle() async throws {
        try await service.continueWithGoogle()
        user = await service.user
    }
        
    func notifyUserAvatarChanged() {
        userAvatarVersion += 1
    }
    
    func updateUserPhotoURL(url: URL, onSuccess: (() -> Void)? = nil) async throws {
        try await service.updateUserPhotoURL(url: url) {
            self.notifyUserAvatarChanged()
        }
    }
}
