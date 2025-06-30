//
//  BaseViewModel.swift
//  MyRouter
//
//  Created by sergemi on 05/05/2025.
//

import Foundation

@Observable
class RoutedViewModel {
    var errorMgr: ErrorManager?
    
    var router: AppRouter
    
    init(errorMgr: ErrorManager?, router: AppRouter) {
        self.errorMgr = errorMgr
        self.router = router
    }
}

@Observable
class AuthViewModel: RoutedViewModel {
    var authService: AuthService
    
    init(errorMgr: ErrorManager?, router: AppRouter, authService: AuthService) {
        self.authService = authService
        super.init(errorMgr:errorMgr, router: router)
    }
}

@Observable
class DataViewModel: AuthViewModel {
    var dataMgr: DataManager
    
    init(errorMgr: ErrorManager?, router: AppRouter, authService: AuthService,  dataMgr: DataManager) {
        self.dataMgr = dataMgr
        super.init(errorMgr: errorMgr, router: router, authService: authService)
    }
}
