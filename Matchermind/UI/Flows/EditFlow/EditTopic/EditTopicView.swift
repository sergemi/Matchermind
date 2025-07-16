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
    
    let module: Module
    let topicId: String?
    let isQuickAdd: Bool
    
    init(module: Module, topicId: String? = nil) {
        self.module = module
        self.topicId = topicId
        self.isQuickAdd = false
    }
    
    init(module: Module, isQuickAdd: Bool) {
        self.module = module
        self.topicId = nil
        self.isQuickAdd = isQuickAdd
    }
    
    var body: some View {
        EditTopicContentView(module: module,
                             topicId: topicId,
                             isQuickAdd: isQuickAdd,
                             errorMgr: errorMgr,
                             router: router,
                             authService: authService,
                             dataMgr: dataMgr)
    }
}

struct EditTopicContentView: View {
    @State private var viewModel: EditTopicViewViewModel
    @State var isFirstLoad: Bool = true
    
    init(module: Module,
         topicId: String?,
         isQuickAdd: Bool,
         errorMgr: ErrorManager?,
         router: AppRouter,
         authService: AuthService,
         dataMgr: DataManager) {
        _viewModel = State(initialValue: EditTopicViewViewModel(module: module,
                                                                topicId: topicId,
                                                                isQuickAdd: isQuickAdd,
                                                                errorMgr: errorMgr,
                                                                router: router,
                                                                authService: authService,
                                                                dataMgr: dataMgr))
    }
    
    var body: some View {
        VStack(spacing: 16) {
            DefaultTextField(text: $viewModel.currentTopic.name, placeholder: "Topic name", title: "Name")
            
            DefaultTextField(text: $viewModel.currentTopic.details, placeholder: "Topic details", title: "Details")
            
            LanguageSelectorButton(title: "Target Language:",
                                   selectedLocaleId: $viewModel.currentTopic.targetLocaleId)
            
            LanguageSelectorButton(title: "Translate Language:",
                                   selectedLocaleId: $viewModel.currentTopic.translateLocaleId)
            
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
            .disabled(!viewModel.canSave)
        }
        .padding()
        .navigationTitle(viewModel.title)
        .alertOnBackButton(viewModel: viewModel)
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
                EditWordPairView(wordPairs: $viewModel.currentTopic.words,
                                 targetLocaleId: viewModel.currentTopic.targetLocaleId,
                                 translateLocaleId: viewModel.currentTopic.translateLocaleId)
                
            case .editWord(let wordPair):
                EditWordPairView(wordPairs: $viewModel.currentTopic.words,
                                 targetLocaleId: viewModel.currentTopic.targetLocaleId,
                                 translateLocaleId: viewModel.currentTopic.translateLocaleId,
                                 editedWordPair: wordPair)
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



//#Preview {
//    PreviewWrapper() {
//        EditTopicView(moduleId: "1")
//    }
//}
