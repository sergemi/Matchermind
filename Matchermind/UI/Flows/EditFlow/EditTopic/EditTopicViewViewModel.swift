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
    let topicId: String?
    var title: String {
        topicId != nil ? "Edit Topic" : "New Topic"
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
}
