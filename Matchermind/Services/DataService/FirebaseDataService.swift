//
//  FirebaseDataService.swift
//  Matchermind
//
//  Created by sergemi on 19/06/2025.
//

import Foundation

actor FirebaseDataService: DataServiceProtocol {
    // MARK: - DataServiceProtocol
    // MARK: User
    func create(user: User) async throws -> User {
        print("create(user")
        throw DataManagerError.userNotFound
    }
    
    func fetchUser(id: String) async throws -> User {
        print("fetchUser")
        let user = User(id: "123", email: "Serg")
        return user
    }
    
    func update(user: User) async throws -> User {
        print("updateUser")
        throw DataManagerError.userNotFound
    }
    
    // MARK: Module
    func create(module: Module) async throws -> Module {
        print("create(module")
        throw DataManagerError.moduleNotFound
    }
    
    func createQuickModule(user: User) async throws -> Module {
        print("createQuickModule")
        let module = Module()
        return module
    }
    
    func fetchModulesPreload(userId: String) async throws -> [ModulePreload] {
        return [] //TODO: implement
    }
    
    func fetchModule(id: String) async throws -> Module {
        print("fetchModule")
//        let module = Module()
//        return module
        throw DataManagerError.moduleNotFound
    }
    
    func update(module: Module) async throws -> Module {
        print("update(module")
        throw DataManagerError.moduleNotFound
    }
    
    // MARK: Topics
    func create(topic: Topic, moduleId: String) async throws -> Module {
        print("create(topic")
        throw DataManagerError.topicNotFound
    }
    
    func update(topic: Topic) async throws -> Topic {
        print("update(topic")
        throw DataManagerError.topicNotFound
    }
    
    func fetchTopic(id: String) async throws -> Topic {
        print("fetchTopic")
        throw DataManagerError.topicNotFound
    }
}
