//
//  RegisterViewModel.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import Foundation

final class SignUpViewModel: AuthViewModel {
    private var errorManager: ErrorManager?
    
    @Published var title = "Sign Up"
    
    @Published var emailTitle = "E-mail"
    @Published var emailHint = "Enter email"
    
    @Published var passwordTitle = "Password"
    @Published var passwordHint = "At least 8 symbols"
    
    @Published var password2Title = "Re enter password"
    @Published var password2Hint = "Must match with the password"
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var email2: String = ""
    @Published var password2: String = ""
    
    init(router: AppRouter, authService: AuthService, errorManager: ErrorManager) {
        self.errorManager = errorManager
        super.init(router: router, authService: authService)
    }
    
    func signUp() {
        print("signIn")
        Task {
            do {
                try await authService.signUp(email: email, password: password)
            }
            catch {
                print("signIn.catch")
                await errorManager?.handleError(error)
            }
        }
    }
}
