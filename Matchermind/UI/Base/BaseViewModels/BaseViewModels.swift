//
//  BaseViewModel.swift
//  MyRouter
//
//  Created by sergemi on 05/05/2025.
//

import Foundation
import SwiftUI

@Observable
class BaseViewModel {
    var errorMgr: ErrorManager?
    
    // Activity (spinner)
    var isActivity = false
    var activityMessaage: String?
    var isActivityModal = false
    
    func startActivity(_ message: String? = nil, modal: Bool = true) {
        isActivity = true
        activityMessaage = message
        isActivityModal = modal
    }
    
    func stopActivity() {
        isActivity = false
        activityMessaage = nil
        isActivityModal = false
    }
    
    init(errorMgr: ErrorManager?) {
        self.errorMgr = errorMgr
    }
}

@Observable
class RoutedViewModel: BaseViewModel {
    var router: AppRouter
    
    init(errorMgr: ErrorManager?, router: AppRouter) {
        self.router = router
        super.init(errorMgr: errorMgr)
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
