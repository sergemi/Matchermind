//
//  EditTopicView.swift
//  Matchermind
//
//  Created by sergemi on 04/07/2025.
//

import SwiftUI

struct EditTopicView: View {
    @Environment(AppRouter.self) var router
    @Environment(AuthService.self) var authService
    @Environment(DataManager.self) var dataMgr
    @Environment(ErrorManager.self) var errorMgr
    
    let moduleId: String?
    let topicId: String?
    
    init(moduleId: String) {
        self.moduleId = moduleId
        self.topicId = nil
    }
    
    init(topicId: String) {
        self.moduleId = nil
        self.topicId = topicId
    }
    
    var body: some View {
        EditTopicContentView(moduleId: moduleId,
                             topicId: topicId,
                             errorMgr: errorMgr,
                             router: router,
                             authService: authService,
                             dataMgr: dataMgr)
    }
}

struct EditTopicContentView: View {
    @State private var viewModel: EditTopicViewViewModel
    
    init(moduleId: String?,
         topicId: String?,
         errorMgr: ErrorManager?,
         router: AppRouter,
         authService: AuthService,
         dataMgr: DataManager) {
        _viewModel = State(initialValue: EditTopicViewViewModel(moduleId: moduleId,
                                                                topicId: topicId,
                                                                errorMgr: errorMgr,
                                                                router: router,
                                                                authService: authService,
                                                                dataMgr: dataMgr))
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text("aaa")
        }
        .navigationTitle(viewModel.title)
    }
}

#Preview {
    PreviewWrapper() {
        EditTopicView(moduleId: "1")
    }
}
