//
//  EditTopicViewViewModel.swift
//  Matchermind
//
//  Created by sergemi on 04/07/2025.
//

import Foundation

@MainActor
@Observable
final class EditTopicViewViewModel: DataViewModel, HasUnsavedChanges{
    let module: Module
    var topicId: String?
    let isQuickAdd: Bool
    var title: String {
        topicId != nil ? "Edit Topic" : "New Topic"
    }
    
    var saveBtnTitle: String {
        isNewTopic ? "New topic" : "Save topic"
    }
    
    var isNewTopic: Bool {
        topicId == nil
    }
    
    var hasUnsavedChanges: Bool {
        currentTopic != startTopic
    }
    
    var canSave: Bool {
        currentTopic.name.count > 0 &&
        hasUnsavedChanges
    }
    
//    var isQuickModule: Bool { TODO: remove
//        module.id == dataMgr.quickModule?.id
//    }
        
    var startTopic: Topic
    var currentTopic: Topic
    
    init(module: Module,
         topicId: String?,
         isQuickAdd: Bool,
         errorMgr: ErrorManager?,
         router: AppRouter,
         authService: AuthService,
         dataMgr: DataManager) {
        
        self.module = module
        self.topicId = topicId
        self.isQuickAdd = isQuickAdd
        
        startTopic = Topic(name: "",
                           details: "",
                           words: [],
                           exercises: [],
                           targetLocaleId: module.targetLocaleId,
                           translateLocaleId: module.translateLocaleId)
        
        currentTopic = Topic(name: "",
                           details: "",
                           words: [],
                           exercises: [],
                           targetLocaleId: module.targetLocaleId,
                           translateLocaleId: module.translateLocaleId)

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
            if isNewTopic {
                
                let newModule = try await dataMgr.create(topic: currentTopic, moduleId: module.id)
                setTopic(currentTopic)
                topicId = currentTopic.id
                                
                if isQuickAdd {
                    dataMgr.quickModule = newModule
                    dataMgr.quickTopic = currentTopic
                    if !router.quickAddPath.isEmpty {
                        router.quickAddPath.removeLast()
                    }
                }
            }
            else {
                let updatedTopic = try await dataMgr.update(topic: currentTopic, moduleId: module.id)
                setTopic(updatedTopic)
            }
        } catch {
            errorMgr?.handleError(error)
        }
    }
    
    func showSelectExerciseView() {
        if isQuickAdd {
            router.quickAddPath.append(EditTopicNavigationLink.editExercises)
        }
        else {
            router.editPath.append(EditTopicNavigationLink.editExercises)
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
