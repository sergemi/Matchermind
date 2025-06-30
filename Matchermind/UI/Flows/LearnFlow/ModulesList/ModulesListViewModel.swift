//
//  ModulesListViewModel.swift
//  Matchermind
//
//  Created by sergemi on 25/06/2025.
//

import Foundation
import Combine

final class ModulesListViewModel: DataViewModel {
    var title = "Modules to learn"
    var modules: [ModulePreload] {
        dataMgr.modulePreloads
    }
    
    var quickModule: ModulePreload? {
        dataMgr.quickModule?.modulePreload
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    override init(errorMgr: ErrorManager?, router: AppRouter, authService: AuthService, dataMgr: DataManager) {
        super.init(errorMgr: errorMgr, router: router, authService: authService, dataMgr: dataMgr)
    }
    
    func selectModule(_ module: ModulePreload) {
        router.navigate(to: .learn(.module(preload: module)))
    }
    
}
