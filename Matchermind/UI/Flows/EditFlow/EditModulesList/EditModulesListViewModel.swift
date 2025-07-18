//
//  EditModulesListViewModel.swift
//  Matchermind
//
//  Created by sergemi on 25/06/2025.
//

import Foundation
import Combine

@MainActor
@Observable
final class EditModulesListViewModel: DataViewModel {
    let title = "Modules to edit"
    var modules: [ModulePreload] {
        guard let user = authService.user else {
            return []
        }
        let allModules = dataMgr.modulePreloads
        let allEditableModules = allModules.filter{$0.authorId == user.id}
        return allEditableModules
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
    
    func deleteModules(withIDs ids: [String]) async {
        do {
            for id in ids {
                _ = try await dataMgr.deleteModule(id: id)
            }
        } catch {
            errorMgr?.handleError(error)
        }
    }
    
    func updateModules() async {
        do {
            try await _ = dataMgr.fetchModulesPreload()
        } catch {
            errorMgr?.handleError(error)
        }
    }
}
