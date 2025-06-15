//
//  DataManager.swift
//  MyRouter
//
//  Created by sergemi on 03/05/2025.
//

import Foundation

class DataManager: ObservableObject {
    @Published var lessons: [MocLesson] = []
    
    func fetchLessons() async throws { }
}

class FirebaseDataManager: DataManager {
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
