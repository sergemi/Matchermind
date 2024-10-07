//
//  SignUpViewModel.swift
//  Matchermind
//
//  Created by sergemi on 07.10.2024.
//

import Foundation

class SignUpViewModel: ObservableObject {
    private var errorManager: ErrorManager?
    private var authService: (any AuthServiceProtocol)?
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var viewTitle = "Sign Up"
    
    func setDependencies(errorManager: ErrorManager, authService: any AuthServiceProtocol) {
        print(">> SignUpViewModel.setDependencies")
        self.errorManager = errorManager
        self.authService = authService
    }
}
