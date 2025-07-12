//
//  QuickAddWordViewModel.swift
//  Matchermind
//
//  Created by sergemi on 10/07/2025.
//

import Foundation

@MainActor
@Observable
final class QuickAddWordViewModel: DataViewModel, HasUnsavedChanges {
    
    init(module: Module,
         topic: Topic,
        errorMgr: ErrorManager?,
         router: AppRouter,
         authService: AuthService,
         dataMgr: DataManager) {
        self.module = module
        self.startTopic = topic
        self.currentTopic = topic
        
        super.init(errorMgr: errorMgr, router: router, authService: authService, dataMgr: dataMgr)
    }
    
    var title = "Quick add word"
    
    var module: Module
//    var topicId: String?
//    
    var startTopic: Topic
    var currentTopic: Topic
    
    var hasUnsavedChanges: Bool {
        currentTopic != startTopic
    }
    
    func saveQuickModule() async {
        print("saveQuickModule")
        defer {
            stopActivity()
        }
        startActivity()
        do {
            let updatedTopic = try await dataMgr.update(topic: currentTopic, moduleId: module.id)
            setTopic(updatedTopic)
            dataMgr.quickTopic = updatedTopic
            
            let updatedModule = try await dataMgr.update(module: module)
            dataMgr.quickModule = updatedModule
        } catch {
            errorMgr?.handleError(error)
        }
    }
    
    //MARK: - Private interface
    private func setTopic(_ topic: Topic) {
        startTopic = topic
        currentTopic = topic
    }
    
    // TODO: remove
    var quickModuleIdStr: String {
        "quickModule: \(dataMgr.quickModule?.name ?? "nil")"
    }
    
    var quickTopickIdStr: String {
        "quickTopickId: \(dataMgr.quickTopic?.name ?? "nil")"
    }
}
