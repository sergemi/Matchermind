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
            try await _ = dataService.fetchUser(by: user.id)
        } catch (DataManagerError.userNotFound) {
            let newUser = try await dataService.createUser(user)
            self.user = newUser
        }
        
        do {
//            try await modulePreloads = dataService.fetchModules(for: user.id)
            try await fetchModulePreloads()
        }
        catch {
            print("Error: \(error)") //TODO: show errors correct
        }
    }
    
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
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
    }
    
    private func resetData() {
        modulePreloads.removeAll()
        quickModule = nil
    }
}
