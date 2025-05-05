//
//  SignInViewModel.swift
//  Matchermind
//
//  Created by sergemi on 05.10.2024.
//

import Foundation

class SignInViewModel: ObservableObject {
    private var errorManager: ErrorManager?
    private var authService: (any AuthServiceProtocolOld)?
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var viewTitle = "Sign in"
    
    @Published var emailTitle = "E-mail"
    @Published var emailHint = "Enter email"
    
    @Published var passwordTitle = "Password"
    @Published var passwordHint = "At least 8 symbols"
    
    func setDependencies(errorManager: ErrorManager, authService: any AuthServiceProtocolOld) {
        print(">> SignInViewModel.setDependencies")
        self.errorManager = errorManager
        self.authService = authService
    }
    
    func signIn(email: String, password: String) {
        print("SignInViewModel.signIn")
        Task {
            do {
                try await authService?.signIn(email: email, password: password)
            }
            catch {
                print("signIn.catch")
                await errorManager?.handleError(error)
            }
        }
    }
    
    @MainActor func showTestError() {
        let error = testError()
        errorManager?.handleError(error)
    }
}
