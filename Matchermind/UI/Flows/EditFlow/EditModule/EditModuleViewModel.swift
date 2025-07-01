//
//  EditModuleViewModel.swift
//  Matchermind
//
//  Created by sergemi on 01/07/2025.
//

import Foundation

@Observable
final class EditModuleViewModel: DataViewModel {
    var title: String {
        guard let moduleName = modulePreload?.name else {
            return "Create module"
        }
        
        return "Edit module '\(moduleName)'"
    }
    var isNewModule: Bool {
        modulePreload == nil
    }
    
    let isQuickModule: Bool
    
    let modulePreload: ModulePreload?
    var startModule: Module?
    var currentModule: Module?
    
    init(modulePreload: ModulePreload?,
         isQuickModule: Bool,
         errorMgr: ErrorManager?,
         router: AppRouter,
         authService: AuthService,
         dataMgr: DataManager) {
        
        self.modulePreload = modulePreload
        self.isQuickModule = isQuickModule

        super.init(errorMgr: errorMgr,
                   router: router,
                   authService: authService,
                   dataMgr: dataMgr)
    }
    
    func getStartModule() async {
        guard let moduleId = modulePreload?.id else {
            return
        }
        
        do {
            //let loadedModule*/ = try await dataMgr.fetchModule(id: moduleId)
            let loadedModule = isNewModule ? try await createNewModule() : try await loadModule(id: moduleId)
            
            await MainActor.run {
                startModule = loadedModule
                currentModule = startModule
            }
        } catch {
            await errorMgr?.handleError(error)
        }
    }
    
    private func loadModule(id: String) async throws -> Module {
        let module = try await dataMgr.fetchModule(id: id)
        
        return module
    }
    
    private func createNewModule() async throws -> Module {
        guard let authorId = await authService.user?.id else {
            throw DataManagerError.userNotFound
        }
        
        let module = Module(name: "", details: "", topics: [], authorId: authorId, isPublic: true)
        return module
    }
}
