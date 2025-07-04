//
//  DataServiceProtocol.swift
//  Matchermind
//
//  Created by sergemi on 19/06/2025.
//

import Foundation

protocol DataServiceProtocol: Actor {
    // MARK: User
    func create(user: User) async throws -> User
    func fetchUser(id: String) async throws -> User
    func update(user: User) async throws -> User
    
    // MARK: Module
    func create(module: Module) async throws -> Module
    func createQuickModule(user: User) async throws -> Module
    func fetchModulesPreload(userId: String) async throws -> [ModulePreload]
    func fetchModule(id: String) async throws -> Module
    func update(module: Module) async throws -> Module
}
