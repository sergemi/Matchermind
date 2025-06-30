//
//  MocDataService.swift
//  Matchermind
//
//  Created by sergemi on 19/06/2025.
//

import Foundation

actor MocDataService: DataServiceProtocol {
    
    private let testDelayMax: Int

    // MARK: - DataServiceProtocol
    // MARK: User
    func createUser(_ user: User) async throws {
        print("createUser")
//        try await testDelay()
        
        var newUser = user
        let quickModule = try await createQuickModule(for: user)
        newUser.quickModuleId = quickModule.id
        users.append(user)
    }
    
    func fetchUser(by id: String) async throws -> User {
        print("fetchUser")
//        try await testDelay()
        
        guard let user = users.first(where: { $0.id == id}) else {
            throw DataManagerError.userNotFound
        }
        return user
    }
    
    // MARK: Module
    func createModule(_ module: Module) async throws {
        print("createModule")
//        try await testDelay()
        
        modules.append(module)
        let modulePreload = module.modulePreload
        modulePreloads.append(modulePreload)
    }
    
    func createQuickModule(for user: User) async throws -> Module {
        print("createQuickModule")
        try await testDelay()
        
        let quickModule = Module(name: "QuickModule",
                                 details: "",
                                 topics: [],
                                 authorId: user.id,
                                 isPublic: false)
        try await createModule(quickModule)
        return quickModule
    }
    
    func fetchModules(for userId: String) async throws -> [ModulePreload] {
        try await testDelay()
        
        let availabledMoules = modulePreloads.filter{$0.isPublic == true || $0.authorId == userId}
        return availabledMoules
    }
    
    func fetchModule(by id: String) async throws -> Module {
        print("fetchModule")
        try await testDelay()
        
        guard let module = modules.first(where: {$0.id == id}) else {
            throw DataManagerError.moduleNotFound
        }
        
        return module
    }
    
    // MARK: moc database
    private var users: [User] = []
    private var modules: [Module] = []
    private var modulePreloads: [ModulePreload] = []
    
    init(testDelayMax: Int = 0, withData: Bool) {
        self.testDelayMax = testDelayMax
        Task {
            if withData {
                try await createMocData()
            }
        }
        
    }
    
    private func createMocData() async throws {
        let user = MockAuthService.mocUser
        
        do {
            try await createUser(user)
            let modulesCount = 50
            for i in 1...modulesCount {
                let module = Module(name: "Module \(i)", details: "Details of module \(i)", topics: [], authorId: user.id, isPublic: true)
                try await createModule(module)
            }
            
            let testModules = try await fetchModules(for: user.id)
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
