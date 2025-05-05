//
//  LoginViewModel.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import Foundation

final class LoginViewModel: AuthViewModel {
    @Published var title = "Login"
    private var errorManager: ErrorManager?
    
    init(router: AppRouter, authService: AuthService, errorManager: ErrorManager) {
        self.errorManager = errorManager
        super.init(router: router, authService: authService)
    }
    
    func login() {
        print("Login")
//        router.isShowingAuth = false
        Task {
            let mocEmail = MockAuthService.mocUserEmail
            let mocPassword = MockAuthService.mocUserPassword
            await authService.signIn(email: mocEmail, password: mocPassword)
        }
    }
    
    func register() {
        router.navigate(to: .auth(.rerister))
    }
    
    @MainActor
    func showTestError() {
        let error = testError()
        errorManager?.handleError(error)
    }
}
