//
//  DataManager.swift
//  MyRouter
//
//  Created by sergemi on 03/05/2025.
//

import Foundation

enum DataManagerError: Error, LocalizedError {
    case unknownError
    case userNotFound
    case moduleNotFound
    case topicNotFound
    case learnedWordNotFound
    case wordPairNotFound
    case updateDataError
}

@Observable
class DataManager {
    private var user: User? = nil
    private var dataService: DataServiceProtocol
    
    var modulePreloads: [ModulePreload] = []
    var quickModule: Module?
    
    func resetUser() async throws {
        print("DataManager.removeUser")
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
        async let modules = fetchModulePreloads()
        
        _ = try await quickModule
        _ = try await modules
    }
    
    func fetchModulePreloads() async throws -> [ModulePreload] {
        guard let user = user else { throw DataManagerError.userNotFound }
        
        let modules = try await dataService.fetchModulesPreload(userId: user.id).filter { $0.id != user.quickModuleId }
        
        await MainActor.run {
            self.modulePreloads = modules
        }
        
        return modules
    }
    
    func fetchModule(by id: String) async throws -> Module {
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
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
    }
    
    private func resetData() {
        modulePreloads.removeAll()
        quickModule = nil
    }
}
