//
//  RegisterViewModel.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import Foundation

final class SignUpViewModel: AuthViewModel {
    var title = "Sign Up"
    
    var emailTitle = "E-mail"
    var emailHint = "Enter email"
    
    var passwordTitle = "Password"
    var passwordHint = "At least 8 symbols"
    
    var password2Title = "Re enter password"
    var password2Hint = "Must match with the password"
    
    var email: String = ""
    var password: String = ""
    
    var email2: String = ""
    var password2: String = ""
    
    func signUp() {
        print("signIn")
        Task {
            do {
                try await authService.signUp(email: email, password: password)
            }
            catch {
                print("signIn.catch")
                await errorMgr?.handleError(error)
            }
        }
    }
}
