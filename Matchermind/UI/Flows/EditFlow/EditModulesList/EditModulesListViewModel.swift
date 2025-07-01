//
//  EditModulesListViewModel.swift
//  Matchermind
//
//  Created by sergemi on 25/06/2025.
//

import Foundation
import Combine

final class EditModulesListViewModel: DataViewModel {
    let title = "Modules to edit"
    var modules: [ModulePreload] {
        dataMgr.modulePreloads
    }
    
    var quickModule: ModulePreload? {
        dataMgr.quickModule?.modulePreload
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func selectModule(_ module: ModulePreload) {
        let isQuickModule = module.id == dataMgr.quickModule?.id
        router.navigate(to: .edit(.editModule(preload: module, isQuickModule: isQuickModule)))
    }
    
    func addModule() {
        router.navigate(to: .edit(.newModule))
    }
    
}
