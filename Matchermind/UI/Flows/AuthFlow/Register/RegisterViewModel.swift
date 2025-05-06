//
//  RegisterViewModel.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import Foundation

final class RegisterViewModel: AuthViewModel {
    private var errorManager: ErrorManager?
    
    @Published var title = "Register"
    
    func register() {
//        router.authPath.removeLast()
        router.doLogin()
    }
}
