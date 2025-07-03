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
        modulePreload == nil ? "Create module" : "Edit module"
    }
    
    var saveBtnTitle: String {
        modulePreload == nil ? "Create module" : "Save module"
    }
    
    var isNewModule: Bool {
        modulePreload == nil
    }
    
    let isQuickModule: Bool
    
    var modulePreload: ModulePreload?
//    var startModule: Module?
//    var currentModule: Module?
    var startModule = Module()
    var currentModule = Module()
    
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
        defer {
            stopActivity()
        }
        startActivity()
        print("!!! Before: \(currentModule.details)")
        do {
            if isNewModule {
                let newModule = try await createNewModule()
                await setModule(newModule)
            }
            else {
                guard let modulePreload = modulePreload else {
                    throw DataManagerError.unknownError // TODO: change error
                }
                let initModule = Module(preload: modulePreload)
                await setModule(initModule)
                
                let loadedModule = try await loadModule(id: modulePreload.id)
                await setModule(loadedModule)
            }
            print("!!!After: \(currentModule.details)")
        } catch {
            await errorMgr?.handleError(error)
        }
        stopActivity()
    }
    
    //MARK: - Private interface
    
    func saveModule() async {
        defer {
            stopActivity()
        }
        startActivity()
        do {
            print("Module \(currentModule.name) saved")
        } catch {
            await errorMgr?.handleError(error)
        }
    }
    
    @MainActor
    private func setModule(_ module: Module) {
        startModule = module
        currentModule = module
    }
    
    private func createNewModule() async throws -> Module {
        guard let authorId = await authService.user?.id else {
            throw DataManagerError.userNotFound
        }
        
        let module = Module(name: "", details: "", topics: [], authorId: authorId, isPublic: true)
        return module
    }
    
    private func loadModule(id: String) async throws -> Module {
        let module = try await dataMgr.fetchModule(id: id)
        
        return module
    }
}
