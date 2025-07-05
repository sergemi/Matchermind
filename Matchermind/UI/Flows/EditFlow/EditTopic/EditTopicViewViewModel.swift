//
//  EditTopicViewViewModel.swift
//  Matchermind
//
//  Created by sergemi on 04/07/2025.
//

import Foundation

@MainActor
@Observable
final class EditTopicViewViewModel: DataViewModel{
    let moduleId: String?
    var topicId: String?
    var title: String {
        topicId != nil ? "Edit Topic" : "New Topic"
    }
    
    var saveBtnTitle: String {
        isNewTopic ? "Create topic" : "Save topic"
    }
    
    var isNewTopic: Bool {
        topicId == nil
    }
    
    var canSave: Bool {
        currentTopic.name.count > 0 &&
        currentTopic != startTopic
    }
    
    var startTopic = Topic()
    var currentTopic = Topic()
    
    init(moduleId: String?,
         topicId: String?,
         errorMgr: ErrorManager?,
         router: AppRouter,
         authService: AuthService,
         dataMgr: DataManager) {
        
        self.moduleId = moduleId
        self.topicId = topicId

        super.init(errorMgr: errorMgr,
                   router: router,
                   authService: authService,
                   dataMgr: dataMgr)
    }
    
    func updateTopic() async {
        print("updateTopic()")
        guard currentTopic == startTopic else { // modul changed from child view but not saved. Don't need load from server
            return
        }
        do {
            let updatedTopic = try await loadTopic(id: currentTopic.id)
            if updatedTopic == currentTopic {
                return
            }
            await MainActor.run {
                print("Topic was changed from last onAppear. Update topic.")
                currentTopic = updatedTopic
            }

        } catch {
            errorMgr?.handleError(error)
        }
    }
    
    func getStartTopic() async {
        if isNewTopic {
            return
        }
        
        defer {
            stopActivity()
        }
        startActivity()
        
        do {
            guard let topicId = topicId else {
                throw DataManagerError.unknownError
            }
            let loaddedTopic = try await loadTopic(id: topicId)
            setTopic(loaddedTopic)
        } catch {
            errorMgr?.handleError(error)
        }
    }
    
    func saveTopic() async {
        defer {
            stopActivity()
        }
        startActivity()
        do {
            guard let moduleId = moduleId else {
                throw DataManagerError.unknownError // TODO: change
            }
            
            if isNewTopic {
                
                _ = try await dataMgr.create(topic: currentTopic, moduleId: moduleId)
                setTopic(currentTopic)
                topicId = currentTopic.id
            }
            else {
                let updatedTopic = try await dataMgr.update(topic: currentTopic, moduleId: moduleId)
                setTopic(updatedTopic)
            }
        } catch {
            errorMgr?.handleError(error)
        }
    }
    
    //MARK: - Private interface
    private func setTopic(_ topic: Topic) {
        startTopic = topic
        currentTopic = topic
    }
    
    private func loadTopic(id: String) async throws -> Topic {
        let topic = try await dataMgr.fetchTopic(id: id)
        
        return topic
    }
}
