//
//  DataManager.swift
//  MyRouter
//
//  Created by sergemi on 03/05/2025.
//

import Foundation

@Observable
class DataManager {
    // MARK: - Setup
    private var user: User? = nil
    private var dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
    }
    
    // MARK: - Data
    
    var modulePreloads: [ModulePreload] = []
    var quickModule: Module?
    
    // MARK: - Interface
    // MARK: User
    func resetUser() async throws {
        print("DataManager.resetUser")
        //clean data
        
        resetData()
        user = nil
    }
    
    func setUser(_ user: User) async throws {
        print("DataManager.setUser")
        try await resetUser()
        self.user = user
        
        do {
            try await _ = dataService.fetchUser(id: user.id)
        } catch (DataManagerError.userNotFound) {
            let newUser = try await dataService.create(user: user)
            self.user = newUser
        }
        
        async let quickModule = fetchQuickModule()
        async let modules = fetchModulesPreload()
        
        _ = try await quickModule
        _ = try await modules
    }
    
    // MARK: Module
    func fetchModulesPreload() async throws -> [ModulePreload] {
        guard let user = user else { throw DataManagerError.userNotFound }
        
        let modules = try await dataService.fetchModulesPreload(userId: user.id).filter { $0.id != user.quickModuleId }
        
        await MainActor.run {
            self.modulePreloads = modules
        }
        
        return modules
    }
    
    func fetchModule(id: String) async throws -> Module {
        let module = try await dataService.fetchModule(id: id)
        return module
    }
    
    func fetchQuickModule() async throws -> Module {
        guard let quickModuleId = user?.quickModuleId else {
            throw DataManagerError.moduleNotFound // TODO: create separate error
        }
        quickModule = try await dataService.fetchModule(id: quickModuleId)
        
        guard let quickModule else {
            throw DataManagerError.moduleNotFound // TODO: create separate error
        }
        
        return quickModule
    }
    
    // MARK: - Internal
    private func resetData() {
        modulePreloads.removeAll()
        quickModule = nil
    }
}
