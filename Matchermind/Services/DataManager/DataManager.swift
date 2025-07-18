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
    var quickTopic: Topic?
    
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
            self.user = try await dataService.fetchUser(id: user.id)
        } catch (DataManagerError.userNotFound) {
            let newUser = try await dataService.create(user: user)
            self.user = newUser
        }
        
        async let quickModule = fetchQuickModule()
        async let modules = fetchModulesPreload()
        
        _ = try await quickModule
        _ = try await modules
        guard let quickTopicId = self.user?.quickTopicId else { return }
        quickTopic = try await dataService.fetchTopic(id: quickTopicId)
    }
    
    func delete(user: User) async throws -> User {
        let user = try await dataService.delete(user: user)
        return user
    }
    
    // MARK: Module
    func fetchModulesPreload() async throws -> [ModulePreload] {
        guard let user = user else { throw DataManagerError.userNotFound }
        
        let modules = try await dataService.fetchModulesPreload(userId: user.id).filter { $0.id != user.quickModuleId }
        
        if modules == self.modulePreloads {
            print("The same module preloads. Don't need change")
            return modules }
        
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
    
    func create(module: Module) async throws -> Module {
        let module = try await dataService.create(module: module)
        return module
    }
    
    func update(module: Module) async throws -> Module {
        let module = try await dataService.update(module: module)
        return module
    }
    
    func delete(module: Module) async throws -> Module {
        let module = try await dataService.delete(module: module)
        return module
    }
    
    func deleteModule(id: String) async throws -> Module {
        let ret = try await dataService.deleteModule(id: id)
        return ret
    }
    
    // MARK: Topic
    func create(topic: Topic, moduleId: String) async throws -> Module {
        let module = try await dataService.create(topic: topic, moduleId: moduleId)
        
        return module
    }
    
    func update(topic: Topic, moduleId: String? = nil) async throws -> Topic {
        let topic = try await dataService.update(topic: topic, moduleId: moduleId)
        return topic
    }
    
    func fetchTopic(id: String) async throws -> Topic {
        let topic = try await dataService.fetchTopic(id: id)
        return topic
    }
    
    func delete(topic: Topic) async throws -> Topic {
        let topic = try await dataService.delete(topic: topic)
        return topic
    }
    
    func deleteTopic(id: String) async throws -> Topic {
        let ret = try await dataService.deleteTopic(id: id)
        return ret
    }
    
    // MARK: - Internal
    private func resetData() {
        modulePreloads.removeAll()
        quickModule = nil
        quickTopic = nil
    }
}
