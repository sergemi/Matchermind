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
    
    override init(router: AppRouter, authService: AuthService, dataMgr: DataManager) {
        super.init(router: router, authService: authService, dataMgr: dataMgr)
    }
    
    func selectModule(_ module: ModulePreload) {
        Task {
            do {
                try await _ = dataMgr.selectModule(by: module.id)
            } catch {
                print("Error selecting module: \(error)") // TODO: show error
            }
        }
        router.navigate(to: .learn(.module(preload: module)))
    }
    
}
