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
        self.startTopic = topic
        self.currentTopic = topic
        
        super.init(errorMgr: errorMgr, router: router, authService: authService, dataMgr: dataMgr)
    }
    
    var title = "Quick add word"
    
//    let module: Module
//    var topicId: String?
//    
    var startTopic: Topic
    var currentTopic: Topic
    
    var hasUnsavedChanges: Bool {
        currentTopic != startTopic
    }
    
    var quickModuleIdStr: String {
        "quickModule: \(dataMgr.quickModule?.name ?? "nil")"
    }
    
    var quickTopickIdStr: String {
        "quickTopickId: \(dataMgr.quickTopic?.name ?? "nil")"
    }
}
