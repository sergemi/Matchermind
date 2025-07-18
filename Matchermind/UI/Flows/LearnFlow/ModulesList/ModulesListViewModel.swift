//
//  ModulesListViewModel.swift
//  Matchermind
//
//  Created by sergemi on 25/06/2025.
//

import Foundation
import Combine

@Observable
final class ModulesListViewModel: DataViewModel {
    let title = "Modules to learn"
    var modules: [ModulePreload] {
        dataMgr.modulePreloads
    }
    
    var quickModule: ModulePreload? {
        dataMgr.quickModule?.modulePreload
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func selectModule(_ module: ModulePreload) {
        router.navigate(to: .learn(.module(preload: module)))
    }
    
    func updateModules() async throws {
        try await _ = dataMgr.fetchModulesPreload()
    }
}
