//
//  FirebaseDataService.swift
//  Matchermind
//
//  Created by sergemi on 19/06/2025.
//

import Foundation
import FirebaseFirestore

actor FirebaseDataService: DataServiceProtocol {
    private let db = Firestore.firestore()
    private var usersCollection: CollectionReference {
        db.collection("users")
    }
    
    private var modulesCollection: CollectionReference {
        db.collection("modules")
    }
    
    private var topicsCollection: CollectionReference {
        db.collection("topics")
    }
    // MARK: - DataServiceProtocol
    // MARK: User
    func create(user: User) async throws -> User {
        print("create(user")
        
        var newUser = user
        
        let quickModule = try await createQuickModule(user: user)
        newUser.quickModuleId = quickModule.id
        newUser.quickTopicId = quickModule.topics.first?.id
        
        try usersCollection.document(newUser.id).setData(from: newUser)
        return newUser
    }
    
    func fetchUser(id: String) async throws -> User {
        print("fetchUser(id")
        
        do {
            return try await usersCollection.document(id).getDocument(as: User.self)
        } catch {
            throw DataManagerError.userNotFound
        }
    }
    
    func update(user: User) async throws -> User {
        print("update(user")
        
        try usersCollection.document(user.id).setData(from: user, merge: true)
        return user
    }
    
    func delete(user: User) async throws -> User {
        print("delete(user")
        
        // Remove all modules of this user
        let modulesToDelete = try await fetchModulesPreload(userId: user.id)
        for modulePreload in modulesToDelete {
            _ = try await deleteModule(id: modulePreload.id)
        }
        
        // Delete the user himself
        try await usersCollection.document(user.id).delete()
        
        return user
    }
    
    // MARK: Module
    func create(module: Module) async throws -> Module {
        print("create(module")
        
        try modulesCollection.document(module.id).setData(from: module)
        return module
    }
    
    func createQuickModule(user: User) async throws -> Module {
        print("createQuickModule")
        
        let quickModule = Module(
            name: "QuickModule",
            details: "\(user.name ?? user.email) quick module",
            topics: [],
            authorId: user.id,
            isPublic: false
        )
        
        let defaultTopic = Topic(
            name: "Default",
            details: "Default topic for quick start",
            words: [],
            exercises: [],
            targetLocaleId: quickModule.targetLocaleId,
            translateLocaleId: quickModule.translateLocaleId
        )
        
        // Add TopicPreload to the quickModule
        var finalModule = quickModule
        finalModule.topics.append(defaultTopic.topicPreload)
        
        // Atomar create module and topic
        let batch = db.batch()
        
        let moduleRef = modulesCollection.document(finalModule.id)
        try batch.setData(from: finalModule, forDocument: moduleRef)
        
        let topicRef = topicsCollection.document(defaultTopic.id)
        try batch.setData(from: defaultTopic, forDocument: topicRef)
        
        try await batch.commit()
        
        return finalModule
    }
    
    func fetchModulesPreload(userId: String) async throws -> [ModulePreload] {
        print("fetchModulesPreload(userId:")
        
        // Firestore doesn't support OR queries on different fields.
        // So we make two queries and merge the results.
        
        // 1. Request for public modules
        let publicModulesQuery = modulesCollection.whereField("isPublic", isEqualTo: true)
        
        // 2. Request for private modules of the current user
        let userModulesQuery = modulesCollection
            .whereField("authorId", isEqualTo: userId)
            .whereField("isPublic", isEqualTo: false)
        
        async let publicModulesDocs = try publicModulesQuery.getDocuments().documents
        async let userModulesDocs = try userModulesQuery.getDocuments().documents
        
        let allDocs = try await (publicModulesDocs + userModulesDocs)
        
        // TODO: need remove duplicates?
        let modules = allDocs.compactMap { try? $0.data(as: Module.self) }
        return modules.map { $0.modulePreload }
    }
    
    func fetchModule(id: String) async throws -> Module {
        print("fetchModule")
        
        do {
            return try await modulesCollection.document(id).getDocument(as: Module.self)
        } catch {
            throw DataManagerError.moduleNotFound
        }
    }
    
    func update(module: Module) async throws -> Module {
        print("update(module")
        
        try modulesCollection.document(module.id).setData(from: module, merge: true)
        return module
    }
    
    func delete(module: Module) async throws -> Module {
        print("delete(module")
        
        let ret = try await deleteModule(id: module.id)
        return ret
    }
    
    func deleteModule(id: String) async throws -> Module {
        print("deleteModule(id")
        
        let moduleToDelete = try await fetchModule(id: id)
        
        // Use Batch to atomically remove a module and all its topics
        let batch = db.batch()
        
        // Set all topics from this module to be deleted
        for topicPreload in moduleToDelete.topics {
            let topicRef = topicsCollection.document(topicPreload.id)
            batch.deleteDocument(topicRef)
        }
        
        // Set the module itself for deletion
        let moduleRef = modulesCollection.document(id)
        batch.deleteDocument(moduleRef)
        
        try await batch.commit()
        
        return moduleToDelete
    }
    
    // MARK: Topics
    func create(topic: Topic, moduleId: String) async throws -> Module {
        print("create(topic")
        
        // Create a topic and atomically add its preload to the array in the module document
        let topicRef = topicsCollection.document(topic.id)
        let moduleRef = modulesCollection.document(moduleId)
        // TODO: check if all work correct
        _ = try await db.runTransaction { (transaction, errorPointer) -> Any? in
            // Get module
            guard let moduleDocument = try? transaction.getDocument(moduleRef) else {
                errorPointer?.pointee = NSError(domain: "AppError", code: 0, userInfo: [
                    NSLocalizedDescriptionKey: "Failed to fetch module document."
                ])
                return nil
            }
            
            // Check if module exist
            guard moduleDocument.exists else {
                errorPointer?.pointee = NSError(domain: "AppError", code: 1, userInfo: [
                    NSLocalizedDescriptionKey: "Module does not exist."
                ])
                return nil
            }
            
            // Add topic
            do {
                try transaction.setData(from: topic, forDocument: topicRef)
            } catch {
                errorPointer?.pointee = error as NSError
                return nil
            }
            
            // Update the topicPreload array in the module
            do {
                let topicPreloadDict = try topic.topicPreload.asDictionary()
                transaction.updateData(["topics": FieldValue.arrayUnion([topicPreloadDict])], forDocument: moduleRef)
            } catch {
                errorPointer?.pointee = error as NSError
                return nil
            }
            
            return nil
        }
        
        // Return the updated module
        return try await fetchModule(id: moduleId)
    }
    
    func update(topic: Topic, moduleId: String?) async throws -> Topic {
        print("update(topic")
        
        try topicsCollection.document(topic.id).setData(from: topic, merge: true)
        
        // If moduleId is passed, TopicPreload in module array must be updated as well.
        // This is a complex operation, the most reliable way is to rebuild the array.
        if let moduleId = moduleId {
            var module = try await fetchModule(id: moduleId)
            if let index = module.topics.firstIndex(where: { $0.id == topic.id }) {
                module.topics[index] = topic.topicPreload
                _ = try await update(module: module)
            }
        }
        
        return topic
    }
    
    func fetchTopic(id: String) async throws -> Topic {
        print("fetchTopic")
        
        do {
            return try await topicsCollection.document(id).getDocument(as: Topic.self)
        } catch {
            throw DataManagerError.topicNotFound
        }
    }
    
    func delete(topic: Topic) async throws -> Topic {
        print("delete(topic")
        
        let ret = try await deleteTopic(id: topic.id)
        return ret
    }
    
    func deleteTopic(id: String) async throws -> Topic {
        print("deleteTopic(id")
        
        let topicToDelete = try await fetchTopic(id: id)
        // Delete the topic itself
        try await topicsCollection.document(id).delete()
        
        // Find all modules that contain this topic and remove preload from them.
        // This is a heavy operation, but necessary for consistency.
        let query = modulesCollection.whereField("topics.id", arrayContains: id)
        let modulesToUpdate = try await query.getDocuments().documents
        
        let batch = db.batch()
        for moduleDoc in modulesToUpdate {
            let moduleRef = modulesCollection.document(moduleDoc.documentID)
            let topicPreloadDict = try topicToDelete.topicPreload.asDictionary()
            batch.updateData(["topics": FieldValue.arrayRemove([topicPreloadDict])], forDocument: moduleRef)
        }
        try await batch.commit()
        
        return topicToDelete
    }
}

