//
//  SignInViewModel.swift
//  Matchermind
//
//  Created by sergemi on 05.10.2024.
//

import SwiftUI

class SignInViewModel: ObservableObject {
    private var errorManager: ErrorManager
    
    init(errorManager: ErrorManager) {
        print(">> SignInViewModel.init")
        self.errorManager = errorManager
    }
    
    func setDependencies(errorManager: ErrorManager) {
        print(">> SignInViewModel.setDependencies")
        self.errorManager = errorManager
    }
    
    func test() {
        print("SignInViewModel.test")
        let error = testError2()
        errorManager.handleError(error)
    }
    
    func signIn(email: String, password: String) async throws {
        print("signIn.call")
        throw testError()
        
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
