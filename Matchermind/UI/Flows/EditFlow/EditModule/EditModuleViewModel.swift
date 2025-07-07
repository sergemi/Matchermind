//
//  EditModuleViewModel.swift
//  Matchermind
//
//  Created by sergemi on 01/07/2025.
//

import Foundation

@MainActor
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
        print("getStartModule()")
        defer {
            stopActivity()
        }
        startActivity()
        do {
            if isNewModule {
                let newModule = try await createNewModule()
                setModule(newModule)
            }
            else {
                guard let modulePreload = modulePreload else {
                    throw DataManagerError.unknownError // TODO: change error
                }
                let initModule = Module(preload: modulePreload)
                setModule(initModule)
                
                let loadedModule = try await loadModule(id: modulePreload.id)
                setModule(loadedModule)
            }
        } catch {
            errorMgr?.handleError(error)
        }
    }
    
    var canSave: Bool {
        currentModule.name.count > 0 &&
        currentModule != startModule
    }
    
    func updateModule() async {
        print("updateModule()")
        
        do {
            guard let moduleId = modulePreload?.id else {
                throw DataManagerError.unknownError
            }
                
            let updatedModule = try await loadModule(id: moduleId)
            if updatedModule == currentModule {
                return
            }
            await MainActor.run {
                print("Module was changed from last onAppear. Update module.")
                currentModule = updatedModule
            }
            
        } catch {
            errorMgr?.handleError(error)
        }
            
    }
    // MARK: Topics
    func newTopic() {
        router.navigate(to: .edit(.newTopic(moduleId: currentModule.id)))
    }
    
    func saveModule() async {
        defer {
            stopActivity()
        }
        startActivity()
        do {
            if isNewModule {
                let createdModule = try await dataMgr.create(module: currentModule)
                setModule(createdModule)
                modulePreload = createdModule.modulePreload
            }
            else {
                let updatedModule = try await dataMgr.update(module: currentModule)
                setModule(updatedModule)
            }
            
            print("Module \(currentModule.name) saved")
        } catch {
            errorMgr?.handleError(error)
        }
    }
    
    //MARK: - Private interface
    private func setModule(_ module: Module) {
        startModule = module
        currentModule = module
    }
    
    private func createNewModule() async throws -> Module {
        guard let authorId = authService.user?.id else {
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
