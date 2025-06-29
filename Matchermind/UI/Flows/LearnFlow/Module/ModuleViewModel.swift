//
//  ModuleViewModel.swift
//  Matchermind
//
//  Created by sergemi on 25/06/2025.
//

import Foundation

@Observable
final class ModuleViewModel: DataViewModel {
    let title: String
    
    let modulePreload: ModulePreload
    var module: Module?
    
    init(modulePreload: ModulePreload,
         router: AppRouter,
         authService: AuthService,
         dataMgr: DataManager) {
        print("ModuleViewModel.init !!!")
        
        self.modulePreload = modulePreload
        title = modulePreload.name

        super.init(router: router,
                   authService: authService,
                   dataMgr: dataMgr)
    }
    
    func loadModule() async throws {
        print("loadModule")
        
        let loadedModule = try await dataMgr.fetchModule(by: modulePreload.id)

        await MainActor.run {
            module = loadedModule
        }
        
        print("Module '\(module?.name ?? "Unnamed")' loaded!")
    }
}
