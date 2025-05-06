//
//  LoginViewModel.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import Foundation

final class LoginViewModel: AuthViewModel {
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
        print("Login")
//        router.isShowingAuth = false
        Task {
//            let mocEmail = MockAuthService.mocUserEmail
//            let mocPassword = MockAuthService.mocUserPassword
//            await authService.signIn(email: mocEmail, password: mocPassword)
            
            do {
                try await authService.signIn(email: email, password: password)
            }
            catch {
                print("signIn.catch")
                await errorManager?.handleError(error)
            }
        }
    }
    
    func signUp() {
        router.navigate(to: .auth(.rerister))
    }
    
    @MainActor
    func showTestError() {
        let error = testError()
        errorManager?.handleError(error)
    }
}
