//
//  LoginViewModel.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import Foundation

final class SignInViewModel: AuthViewModel {
    private var errorManager: ErrorManager?
    
    @Published var title = "Sign in"
    
    @Published var emailTitle = "E-mail"
    @Published var emailHint = "Enter email"
    
    @Published var passwordTitle = "Password"
    @Published var passwordHint = "At least 8 symbols"
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    init(router: AppRouter, authService: AuthService, errorManager: ErrorManager) {
        self.errorManager = errorManager
        super.init(router: router, authService: authService)
    }
    
    func signIn() {
        print("signIn")
        Task {
            do {
                try await authService.signIn(email: email, password: password)
            }
            catch {
                print("signIn.catch")
                await errorManager?.handleError(error)
            }
        }
    }
    
    func continueWithGoogle() {
        Task {
            do {
                try await authService.continueWithGoogle()
            }
            catch {
                await errorManager?.handleError(error)
            }
        }
    }
    
    func signUp() {
        router.navigate(to: .auth(.signUp))
    }
    
    //TODO: remove after debug finish
    @MainActor
    func showTestError() {
        let error = testError()
        errorManager?.handleError(error)
    }
}
