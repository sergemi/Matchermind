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
    func createUser(_ user: User) async throws -> User {
        print("createUser")
        throw DataManagerError.userNotFound
    }
    
    func fetchUser(by id: String) async throws -> User {
        print("fetchUser")
        let user = User(id: "123", email: "Serg")
        return user
    }
    
    func updateUser(_ user: User) async throws -> User {
        print("updateUser")
        throw DataManagerError.userNotFound
    }
    
    // MARK: Module
    func createModule(_ module: Module) async throws {
        print("createModule")
    }
    
    func createQuickModule(for user: User) async throws -> Module {
        print("createQuickModule")
        let module = Module()
        return module
    }
    
    func fetchModules(for userId: String) async throws -> [ModulePreload] {
        return [] //TODO: implement
    }
    
    func fetchModule(by id: String) async throws -> Module {
        print("fetchModule")
//        let module = Module()
//        return module
        throw DataManagerError.moduleNotFound
    }
    
    
}
