//
//  MocDataService.swift
//  Matchermind
//
//  Created by sergemi on 19/06/2025.
//

import Foundation

actor MocDataService: DataServiceProtocol {
    // MARK: - Setup
    private let testDelayMax: Int
    
    init(testDelayMax: Int = 0, withData: Bool) {
        self.testDelayMax = testDelayMax
        Task {
            if withData {
                try await createMocData()
            }
        }
    }

    // MARK: - DataServiceProtocol
    // MARK: User
    func create(user: User) async throws -> User {
        print("create(user")
//        try await testDelay()
        
        var newUser = user
        let quickModule = try await createQuickModule(user: user)
        newUser.quickModuleId = quickModule.id
        users.append(newUser)
        return newUser
    }
    
    func fetchUser(id: String) async throws -> User {
        print("fetchUser")
//        try await testDelay()
        
        guard let user = users.first(where: { $0.id == id}) else {
            throw DataManagerError.userNotFound
        }
        return user
    }
    
    func update(user: User) async throws -> User {
        guard let index = users.firstIndex(of: try await fetchUser(id: user.id)) else {
            throw DataManagerError.userNotFound
        }
        
        users[index] = user
        return users[index]
    }
    
    // MARK: Module
    func create(module: Module) async throws -> Module {
        print("create(module(module")
//        try await testDelay()
        
        modules.append(module)
        let modulePreload = module.modulePreload
        modulePreloads.append(modulePreload)
        return module
    }
    
    func createQuickModule(user: User) async throws -> Module {
        print("createQuickModule")
//        try await testDelay()
        
        let quickModule = Module(name: "QuickModule",
                                 details: "\(user.name ?? user.email) quick module",
                                 topics: [],
                                 authorId: user.id,
                                 isPublic: false)
        let module = try await create(module: quickModule)
        
        return module
    }
    
    func fetchModulesPreload(userId: String) async throws -> [ModulePreload] {
        try await testDelay()
        
        let availabledMoules = modulePreloads.filter{$0.isPublic == true || $0.authorId == userId}
        return availabledMoules
    }
    
    func fetchModule(id: String) async throws -> Module {
        print("fetchModule")
        try await testDelay()
        
        guard let module = modules.first(where: {$0.id == id}) else {
            throw DataManagerError.moduleNotFound
        }
        
        return module
    }
    
    func update(module: Module) async throws -> Module {
        print("update(module")
        throw DataManagerError.moduleNotFound
    }
    
    // MARK: - moc database
    private var users: [User] = []
    private var modules: [Module] = []
    private var modulePreloads: [ModulePreload] = []
    
    private func createMocData() async throws {
        let user = MockAuthService.mocUser
        
        do {
            _ = try await create(user: user)
            let modulesCount = 50
            for i in 1...modulesCount {
                let module = Module(name: "Module \(i)", details: "Details of module \(i)", topics: [], authorId: user.id, isPublic: true)
                _ = try await create(module: module)
            }
            
            let testModules = try await fetchModulesPreload(userId: user.id)
            print("availabled \(testModules.count) modules")
        }
        catch {
            print("error")
        }
    }
    
    // MARK: - Private interface
    nonisolated private func testDelay() async throws {
        if testDelayMax == 0 {
            return
        }
        let delay = Int.random(in: 0...testDelayMax)
        try await Task.sleep(for: .seconds(delay))
    }
}
