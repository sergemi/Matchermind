//
//  DataServiceProtocol.swift
//  Matchermind
//
//  Created by sergemi on 19/06/2025.
//

import Foundation

protocol DataServiceProtocol: Actor {
    // MARK: User
    func createUser(_ user: User) async throws -> User
    func fetchUser(by id: String) async throws -> User
    func updateUser(_ user: User) async throws -> User
    
    // MARK: Module
    func createModule(_ module: Module) async throws
    func createQuickModule(for user: User) async throws -> Module
    func fetchModules(for userId: String) async throws -> [ModulePreload]
    func fetchModule(by id: String) async throws -> Module
}
