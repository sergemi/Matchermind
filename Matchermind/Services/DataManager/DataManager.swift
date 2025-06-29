//
//  DataManager.swift
//  MyRouter
//
//  Created by sergemi on 03/05/2025.
//

import Foundation

@Observable
class DataManager {
    var lessons: [MocLesson] = [] // todo: remove
    private var user: User? = nil
    private var dataService: DataServiceProtocol
    
    var modulePreloads: [ModulePreload] = []
    var currentModule: Module?
    var quickModule: Module?
    
    func removeUser() async throws {
        print("DataManager.removeUser")
        //clean data
        
        resetData()
        user = nil
    }
    
    func setUser(_ user: User) async throws {
        print("DataManager.setUser")
        try await removeUser()
        self.user = user
        
        do {
            try await _ = dataService.fetchUser(by: user.id)
        } catch (DataManagerError.userNotFound) {
            try await dataService.createUser(user)
        }
        
        do {
//            try await modulePreloads = dataService.fetchModules(for: user.id)
            try await fetchModulePreloads()
        }
        catch {
            print("Error: \(error)") //TODO: show errors correct
        }
    }
    
    func fetchLessons() async throws { }
    
    func fetchModulePreloads() async throws {
        guard let user = user else { throw DataManagerError.userNotFound }
        
        let modules = try await dataService.fetchModules(for: user.id)
        if let quickModulePreview = modules.first(where: {$0.id == user.quickModuleId}) {
            self.quickModule = try await dataService.fetchModule(by: quickModulePreview.id)
        }
        
        await MainActor.run {
            
            self.modulePreloads = modules
        }
    }
    
    func fetchModule(by id: String) async throws -> Module {
        let module = try await dataService.fetchModule(by: id)
        return module
    }
    
    func selectModule(by id: String) async throws -> Module {
        await MainActor.run {
            currentModule = nil
        }
        let module = try await fetchModule(by: id)
        
        await MainActor.run {
            currentModule = module
        }
        
        return module
    }
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
    }
    
    private func resetData() {
        lessons.removeAll() // todo: remove
        modulePreloads.removeAll()
        currentModule = nil
        quickModule = nil
    }
}

class FirebaseDataManager: DataManager {
    convenience init() {
        let dataService = MocDataService()
        self.init(dataService: dataService)
    }
    
    @MainActor
    override func fetchLessons() async throws {
        try await super.fetchLessons()
        
        lessons = [
            MocLesson(name: "First lesson"),
            MocLesson(name: "Second lesson"),
            MocLesson(name: "Third lesson"),
        ]
    }
}

class MocDataManager: DataManager {
    convenience init() {
        let dataService = MocDataService()
        self.init(dataService: dataService)
    }
    
    @MainActor
    override func fetchLessons() async throws {
        try await super.fetchLessons()
        
        lessons = [
            MocLesson(name: "Moc lesson 1"),
            MocLesson(name: "Moc lesson 2"),
            MocLesson(name: "Moc lesson 3"),
        ]
    }
}
