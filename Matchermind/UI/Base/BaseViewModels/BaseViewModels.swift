//
//  BaseViewModel.swift
//  MyRouter
//
//  Created by sergemi on 05/05/2025.
//

import Foundation

@Observable
class RoutedViewModel {
    var router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
    }
}

class AuthViewModel: RoutedViewModel {
    var authService: AuthService
    
    init(router: AppRouter, authService: AuthService) {
        self.authService = authService
        super.init(router: router)
    }
}

class DataViewModel: AuthViewModel {
    var dataMgr: DataManager
    
    init(router: AppRouter, authService: AuthService,  dataMgr: DataManager) {
        self.dataMgr = dataMgr
        super.init(router: router, authService: authService)
    }
}
