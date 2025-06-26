//
//  MocDataService.swift
//  Matchermind
//
//  Created by sergemi on 19/06/2025.
//

import Foundation

actor MocDataService: DataServiceProtocol {
    // MARK: - DataServiceProtocol
    // MARK: User
    func createUser(_ user: User) async throws {
        print("createUser")
        var newUser = user
        let quickModule = try await createQuickModule(for: user)
        newUser.quickModuleId = quickModule.id
        users.append(user)
    }
    
    func fetchUser(by id: String) async throws -> User {
        print("fetchUser")
        guard let user = users.first(where: { $0.id == id}) else {
            throw DataManagerError.userNotFound
        }
        return user
    }
    
    // MARK: Module
    func createModule(_ module: Module) async throws {
        print("createModule")
        modules.append(module)
        let modulePreload = module.modulePreload
        modulePreloads.append(modulePreload)
    }
    
    func createQuickModule(for user: User) async throws -> Module {
        print("createQuickModule")
        let quickModule = Module(name: "QuickModule",
                                 details: "",
                                 topics: [],
                                 authorId: user.id,
                                 isPublic: false)
        try await createModule(quickModule)
        return quickModule
    }
    
    func fetchModules(for userId: String) async throws -> [ModulePreload] {
        let availabledMoules = modulePreloads.filter{$0.isPublic == true || $0.authorId == userId}
        return availabledMoules
    }
    
    func fetchModule(by id: String) async throws -> Module {
        print("fetchModule")
//        let module = Module()
        guard let module = modules.first(where: {$0.id == id}) else {
            throw DataManagerError.moduleNotFound
        }
        
        return module
        
    }
    
    // MARK: moc database
    private var users: [User] = []
    private var modules: [Module] = []
    private var modulePreloads: [ModulePreload] = []
    
    init() {
        Task {
//            let user = User(id: "123", email: "test@test.com", name: "TestUser")
            let user = MockAuthService.mocUser
            
            do {
                try await createUser(user)
                let modulesCount = 50
                for i in 1...modulesCount {
                    let module = Module(name: "Module \(i)", details: "Details of module \(i)", topics: [], authorId: user.id, isPublic: true)
                    try await createModule(module)
                }
                
//                let module1 = Module(name: "Module 1", details: "Detail 1", topics: [], authorId: user.id, isPublic: true)
//                let module2 = Module(name: "Module 2", details: "Detail 2", topics: [], authorId: user.id, isPublic: true)
//                let module3 = Module(name: "Module 3", details: "Detail 3", topics: [], authorId: user.id, isPublic: true)
//                
//                try await createModule(module1)
//                try await createModule(module2)
//                try await createModule(module3)
                
                
                let testModules = try await fetchModules(for: user.id)
                print("availabled \(testModules.count) modules")
            }
            catch {
                print("error")
            }
        }
        
    }
}
