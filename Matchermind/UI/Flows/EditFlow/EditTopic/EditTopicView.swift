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
    
    let moduleId: String
    let topicId: String?

    init(moduleId: String, topicId: String? = nil) {
        self.moduleId = moduleId
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
    @State var isFirstLoad: Bool = true
    
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
            
            Button {
                print("Go to excercises")
                viewModel.router.editPath.append(EditTopicNavigationLink.editExercises)
            } label: {
                EditModuleExercisesView(exercises: $viewModel.currentTopic.exercises)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            
            EditWordsListView(words: $viewModel.currentTopic.words, onAdd: {
                viewModel.router.editPath.append(EditTopicNavigationLink.addWord)
            }, onEdit: {id in
                if let wordPair = viewModel.currentTopic.words.first(where: {$0.id == id}) {
                    viewModel.router.editPath.append(EditTopicNavigationLink.editWord(wordPair))
                }
            })
            
            Button(viewModel.saveBtnTitle) {
                Task {
                    await viewModel.saveTopic()
                }
            }
            .disabled(!viewModel.hasUnsavedChanges)
        }
        .padding()
        .navigationTitle(viewModel.title)
        .activitySpinner(viewModel: viewModel)
        .onAppear() {
            Task {
                if isFirstLoad {
                    isFirstLoad = false
                    await viewModel.getStartTopic()
                }
                else {
                    await viewModel.updateTopic()
                }
            }
        }
        .navigationDestination(for: EditTopicNavigationLink.self) { link in
            switch link {
            case .editExercises:
                EditExercisesView(exercises: $viewModel.currentTopic.exercises)
                
            case .addWord:
                EditWordPairView(wordPairs: $viewModel.currentTopic.words)
                
            case .editWord(let wordPair):
                EditWordPairView(wordPairs: $viewModel.currentTopic.words, editedWordPair: wordPair)
            }
                
        }
    }
    
    // TODO: Internal navigation (not used AppRouter)
    struct EditExercisesLink: Hashable {}
    
    enum EditTopicNavigationLink: Hashable {
        case editExercises
        case addWord
        case editWord(WordPair)
    }
    
}



#Preview {
    PreviewWrapper() {
        EditTopicView(moduleId: "1")
    }
}
