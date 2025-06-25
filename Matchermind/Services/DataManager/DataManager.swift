//
//  DataManager.swift
//  MyRouter
//
//  Created by sergemi on 03/05/2025.
//

import Foundation

class DataManager: ObservableObject {
    @Published var lessons: [MocLesson] = [] // todo: remove
    private var user: User? = nil
    private var dataService: DataServiceProtocol
    
    @Published var modulePreloads: [ModulePreload] = []
    @Published var currentModule: Module?
    @Published var quickModule: Module?
    
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
    }
    
    func fetchLessons() async throws { }
    
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
