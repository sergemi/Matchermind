//
//  LoginViewModel.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import Foundation

final class SignInViewModel: AuthViewModel {
    private var errorManager: ErrorManager?
    
    var title = "Sign in"
    
    var emailTitle = "E-mail"
    var emailHint = "Enter email"
    
    var passwordTitle = "Password"
    var passwordHint = "At least 8 symbols"
    
    var email: String = ""
    var password: String = ""
    
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
    
    @MainActor
    func continueWithGoogle() {
        Task {
            do {
                try await authService.continueWithGoogle()
            }
            catch {
//                await errorManager?.handleError(error)
                errorManager?.handleError(error)
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
