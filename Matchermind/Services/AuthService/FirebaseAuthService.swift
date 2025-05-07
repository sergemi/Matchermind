//
//  FirebaseAuthService.swift
//  MyRouter
//
//  Created by sergemi on 06/05/2025.
//

import Foundation

//import FirebaseCore // ?
import Firebase
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift // ?

actor FirebaseAuthService: AuthServiceProtocol {
    var user: User?
    
    private var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        // Subscribe to firebase auth state changes
        handle = Auth.auth().addStateDidChangeListener { [weak self] _, firUser in
            guard let firUser = firUser else {
                return
            }
            print("photoURL: \(firUser.photoURL)")
            
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
        googleSignOut()
        user = nil
    }
    
    @MainActor
    func continueWithGoogle() async throws {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Получаем rootViewController
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootVC = windowScene.windows.first(where: \.isKeyWindow)?.rootViewController else {
            throw URLError(.badURL)
        }

        // Вызываем Google Sign-In
        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootVC)

        guard let idToken = result.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }

        let accessToken = result.user.accessToken.tokenString
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

        // Авторизация в Firebase
        try await Auth.auth().signIn(with: credential)
    }
    
    private func googleSignOut() {
        GIDSignIn.sharedInstance.signOut() // TODO: try to make assync ?
        print("Google sign out")
    }
}
