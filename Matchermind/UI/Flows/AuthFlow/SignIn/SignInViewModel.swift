//
//  LoginViewModel.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import Foundation

final class SignInViewModel: AuthViewModel {
    var title = "Sign in"
    
    var emailTitle = "E-mail"
    var emailHint = "Enter email"
    
    var passwordTitle = "Password"
    var passwordHint = "At least 8 symbols"
    
    var email: String = ""
    var password: String = ""
    
    func signIn() {
        print("signIn")
        Task {
            do {
                try await authService.signIn(email: email, password: password)
            }
            catch {
                print("signIn.catch")
                await errorMgr?.handleError(error)
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
//                await errorMgr?.handleError(error)
                errorMgr?.handleError(error)
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
        errorMgr?.handleError(error)
    }
}
