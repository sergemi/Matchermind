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
    var hasUnsavedChanges: Bool = false
    
    var title = "Quick add word"
    
//    let module: Module
//    var topicId: String?
//    
//    var startTopic: Topic
//    var currentTopic: Topic
    
    var quickModuleIdStr: String {
        "quickModule: \(dataMgr.quickModule?.name ?? "nil")"
    }
    
    var quickTopickIdStr: String {
        "quickTopickId: \(dataMgr.quickTopic?.name ?? "nil")"
    }
}
