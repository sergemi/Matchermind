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
        newUser.quickTopicId = quickModule.topics.first?.id
        
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
        print("update(user")
        guard let index = users.firstIndex(of: try await fetchUser(id: user.id)) else {
            throw DataManagerError.userNotFound
        }
        
        users[index] = user
        return users[index]
    }
    
    func delete(user: User) async throws -> User {
        print("delete(user")
        guard let index = users.firstIndex(where: {$0.id == user.id}) else {
            throw DataManagerError.userNotFound
        }
        
        return users.remove(at: index)
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
        
        let defTopic = Topic(name: "Default",
                             details: "",
                             words: [],
                             exercises: [],
                             targetLocaleId: quickModule.targetLocaleId,
                             translateLocaleId: quickModule.targetLocaleId)
        let ret = try await create(topic: defTopic, moduleId: quickModule.id)
        
        return ret
    }
    
    func fetchModulesPreload(userId: String) async throws -> [ModulePreload] {
        print("fetchModulesPreload")
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
        guard let moduleIndex = modules.firstIndex(where: {$0.id == module.id}) else {
            throw DataManagerError.moduleNotFound
        }
        modules[moduleIndex] = module
        
        let modulePreload = module.modulePreload
        guard let modulePreloadIndex = modulePreloads.firstIndex(where: {$0.id == module.id}) else {
            throw DataManagerError.modulePreloadNotFound
        }
        modulePreloads[modulePreloadIndex] = modulePreload
        
        return module
    }
    
    func delete(module: Module) async throws -> Module {
        print("delete(module")
        let moduleId = module.id
        
        return try await deleteModule(id: moduleId)
    }
    
    func deleteModule(id: String) async throws -> Module {
        print("deleteModule(id")
        print("modules: \(modules.count), modulePreloads: \(modulePreloads.count)")
        
        guard let moduleIndex = modules.firstIndex(where: {$0.id == id }) else {
            throw DataManagerError.moduleNotFound
        }
        let ret = modules.remove(at: moduleIndex)
        
        guard let modulePreloadIndex = modulePreloads.firstIndex(where: {$0.id == id }) else {
            throw DataManagerError.modulePreloadNotFound
        }
        modulePreloads.remove(at: modulePreloadIndex)
        print("after delete")
        print("modules: \(modules.count), modulePreloads: \(modulePreloads.count)")
        
        return ret
    }
    
    // MARK: Topics
    func create(topic: Topic, moduleId: String) async throws -> Module {
        var module = try await fetchModule(id: moduleId)
        print("create(topic")
//        testDelay()
        
        topics.append(topic)
        let topicPreload = topic.topicPreload
        topicPreloads.append(topicPreload)
        
        module.topics.append(topicPreload)
        module = try await update(module: module)
        
        return module
    }
    
    func update(topic: Topic, moduleId: String?) async throws -> Topic {
        print("update(topic")
        try await testDelay()
        
        guard let topicIndex = topics.firstIndex(where: {$0.id == topic.id }) else {
            throw DataManagerError.topicNotFound
        }
        topics[topicIndex] = topic
        
        let topicPreload = topic.topicPreload
        guard let topicPreloadIndex = topicPreloads.firstIndex(where: {$0.id == topic.id }) else {
            throw DataManagerError.topicPreloadNotFound
        }
        topicPreloads[topicPreloadIndex] = topicPreload
        
        if let moduleId = moduleId {
            var module = try await fetchModule(id: moduleId)
            guard let topicPreloadIndex = module.topics.firstIndex(where: {$0.id == topic.id }) else {
                throw DataManagerError.topicPreloadNotFound
            }
            module.topics[topicPreloadIndex] = topicPreload
            _ = try await update(module: module)
        }
        
        return topic
    }
    
    func fetchTopic(id: String) async throws -> Topic {
        print("fetchTopic")
        try await testDelay()
        
        guard let topic = topics.first(where: {$0.id == id}) else {
            throw DataManagerError.topicNotFound
        }
        
        return topic
    }
    
    func delete(topic: Topic) async throws -> Topic {
        print("delete(topic")
        
        let id = topic.id
        let ret = try await deleteTopic(id: id)
        
        return ret
    }
    
    func deleteTopic(id: String) async throws -> Topic {
        print("deleteTopic(id")
        print("modules: \(topics.count), topicPreloads: \(topicPreloads.count)")
        guard let topicIndex = topics.firstIndex(where: {$0.id == id }) else {
            throw DataManagerError.topicNotFound
        }
        let ret = topics.remove(at: topicIndex)
        
        guard let topicPreloadIndex = topicPreloads.firstIndex(where: {$0.id == id }) else {
            throw DataManagerError.topicPreloadNotFound
        }
        topicPreloads.remove(at: topicPreloadIndex)
        print("after delete")
        print("modules: \(topics.count), topicPreloads: \(topicPreloads.count)")
        return ret
    }
    
    // MARK: - moc database
    private var users: [User] = []
    private var modules: [Module] = []
    private var modulePreloads: [ModulePreload] = []
    private var topicPreloads: [TopicPreload] = []
    private var topics: [Topic] = []
    
    private func createMocData() async throws {
        let user = MockAuthService.mocUser
        
        do {
            _ = try await create(user: user)
            let modulesCount = 5
            for i in 1...modulesCount {
                let module = Module(name: "Module \(i)",
                                    details: "Details of module \(i)",
                                    topics: [],
                                    authorId: user.id,
                                    isPublic: true,
                                    targetLocaleId: "", // TODO: put something
                                    translateLocaleId: "")
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
