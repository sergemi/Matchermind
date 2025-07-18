//
//  QuickAddWordView.swift
//  Matchermind
//
//  Created by sergemi on 10/07/2025.
//

import SwiftUI

struct QuickAddWordView: View {
    @Environment(AppRouter.self) var router
    @Environment(AuthService.self) var authService
    @Environment(DataManager.self) var dataMgr
    @Environment(ErrorManager.self) var errorMgr
    
    var body: some View {
        if let quickModule = dataMgr.quickModule,
           let quickTopic = dataMgr.quickTopic {
            QuickAddWordContentView(topic: quickTopic,
                                    errorMgr: errorMgr,
                                    router: router,
                                    authService: authService,
                                    dataMgr: dataMgr)
            .id(quickTopic.id)
            
        }
        else {
            VStack(spacing: 16) {
                ProgressView()
                Text("Loading quick module...")
                    .font(.callout)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct QuickAddWordContentView: View {
    @State private var viewModel: QuickAddWordViewModel
    
    init(topic: Topic,
         errorMgr: ErrorManager?,
         router: AppRouter,
         authService: AuthService,
         dataMgr: DataManager) {
        _viewModel = State(initialValue: QuickAddWordViewModel(topic: topic,
                                                               errorMgr: errorMgr,
                                                               router: router,
                                                               authService: authService,
                                                               dataMgr: dataMgr))
    }
    
    var body: some View {
        VStack{
            Button {
                viewModel.showTopicPicker = true
            } label: {
                HStack {
                    Text("Topic:")
                    Spacer()
                    Text(viewModel.dataMgr.quickTopic?.name ?? "Select topic")
                        .foregroundColor(.accentColor)
                    Image(systemName: "chevron.down")
                        .font(.caption)
                }
                .contentShape(Rectangle())
                .padding()
            }
            
            Text(viewModel.quickModuleIdStr)
            Text(viewModel.quickTopickStr)
            Text(viewModel.currentTopicStr)
            //TODO: remove
            //            Text("locales: '\(viewModel.currentTopic.targetLocaleId)' - '\(viewModel.currentTopic.translateLocaleId)'")
            //            Text("locales2: '\(viewModel.dataMgr.quickTopic?.targetLocaleId ?? "unknown")' - '\(viewModel.dataMgr.quickTopic?.translateLocaleId ?? "unknown")'")
            
            EditWordPairView(wordPairs: $viewModel.currentTopic.words,
                             targetLocaleId: viewModel.dataMgr.quickTopic?.targetLocaleId ?? "",
                             translateLocaleId: viewModel.dataMgr.quickTopic?.translateLocaleId ?? "",
                             isSubView: true,
                             isRootView: true)
            .id(viewModel.dataMgr.quickTopic?.id ?? viewModel.currentTopic.id)
            if viewModel.hasUnsavedChanges && !viewModel.autosave {
                Button("Save") {
                    Task {
                        await viewModel.saveQuickModule()
                    }
                }
            }
        }
        .activitySpinner(viewModel: viewModel)
        .navigationTitle(viewModel.title)
        .sheet(isPresented: $viewModel.showTopicPicker) {
            VStack {
                TopicPickerView(
                    topics: viewModel.dataMgr.quickModule?.topics ?? [],
                    selected: viewModel.dataMgr.quickTopic?.topicPreload
                ) { newTopic in
                    Task {
                        await viewModel.setQuickTopic(preload: newTopic)
                        print(newTopic.name)
                    }
                }
                
                Button("New Topic") {
                    print("Create new topic")
                    viewModel.navigateToNewTopic()
                }
            }
        }
    }
}
