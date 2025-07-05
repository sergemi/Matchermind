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
            DefaultTextField(text: $viewModel.currentTopic.name, placeholder: "Topic name", title: "Name")
            
            DefaultTextField(text: $viewModel.currentTopic.details, placeholder: "Topic details", title: "Details")
            
            EditModuleExercisesView(exercises: $viewModel.currentTopic.exercises)
            
            EditWordsListView(words: $viewModel.currentTopic.words, onAdd: {
                print("TODO: add word")
            })
            
            Button(viewModel.saveBtnTitle) {
                Task {
                    await viewModel.saveTopic()
                }
            }
            .disabled(!viewModel.canSave)
        }
        .padding()
        .navigationTitle(viewModel.title)
    }
}

#Preview {
    PreviewWrapper() {
        EditTopicView(moduleId: "1")
    }
}
