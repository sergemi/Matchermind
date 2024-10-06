//
//  SignInViewModel.swift
//  Matchermind
//
//  Created by sergemi on 05.10.2024.
//

import SwiftUI

class SignInViewModel: ObservableObject {
    private var errorManager: ErrorManager?
    private var authService: (any AuthServiceProtocol)?
    
    func setDependencies(errorManager: ErrorManager, authService: any AuthServiceProtocol) {
        print(">> SignInViewModel.setDependencies")
        self.errorManager = errorManager
        self.authService = authService
    }
    
    func test() {
        print("SignInViewModel.test")
        let error = testError2()
        errorManager?.handleError(error)
    }
    
    func signIn(email: String, password: String) async throws {
        print("SignInViewModel.signIn")
        try await authService?.signIn(email: email, password: password)
//        throw testError()
        
//        try await authService.signIn(email: email, password: password)
        /*
        do {
            throw testError()
//            try await authService.signIn(email: email, password: password)
        }
        catch {
            print("signIn.catch")
            errorManager.handleError(error)
        }
         */
    }
}
