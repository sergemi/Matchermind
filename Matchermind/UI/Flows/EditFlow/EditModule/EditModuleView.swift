//
//  EditModuleView.swift
//  Matchermind
//
//  Created by sergemi on 01/07/2025.
//

import SwiftUI

struct EditModuleView: View {
    @Environment(AppRouter.self) var router
    @Environment(AuthService.self) var authService
    @Environment(DataManager.self) var dataMgr
    @Environment(ErrorManager.self) var errorMgr
    
    let modulePreload: ModulePreload?
    let isQuickModule: Bool
    
    var body: some View {
        EditModuleContentView(modulePreload: modulePreload,
                              isQuickModule: isQuickModule,
                              errorMgr: errorMgr,
                              router: router,
                              authService: authService,
                              dataMgr: dataMgr)
    }
}

struct EditModuleContentView: View {
    @State private var viewModel: EditModuleViewModel
    @State var isFirstLoad: Bool = true
    
    init(modulePreload: ModulePreload?, isQuickModule: Bool, errorMgr: ErrorManager?, router: AppRouter, authService: AuthService, dataMgr: DataManager) {
        _viewModel = State(initialValue: EditModuleViewModel(modulePreload: modulePreload,
                                                             isQuickModule: isQuickModule,
                                                             errorMgr: errorMgr,
                                                             router: router,
                                                             authService: authService,
                                                             dataMgr: dataMgr))
    }
    
    var body: some View {
        VStack(spacing: 16) {
            DefaultTextField(text: $viewModel.currentModule.name, placeholder: "Module name", title: "Name")
            
            DefaultTextField(text: $viewModel.currentModule.details, placeholder: "Module details", title: "Details")
            
            Toggle("Public", isOn: $viewModel.currentModule.isPublic)
            
            EditTopicsListView(topics: $viewModel.currentModule.topics, moduleId: viewModel.currentModule.id, onAdd: viewModel.newTopic,
                               onDelete: { ids, completion in
                                   Task {
                                       await viewModel.deleteTopics(withIDs: ids)
                                       completion()
                                   }
                               })
                .disabled(viewModel.isNewModule)
            
            Button(viewModel.saveBtnTitle) {
                Task {
                    await viewModel.saveModule()
                }
            }
            .disabled(!viewModel.hasUnsavedChanges)
        }
        .padding()
        .navigationTitle(viewModel.title)
        .alertOnBackButton(viewModel: viewModel)
        .activitySpinner(viewModel: viewModel)
        .onAppear() {
            Task {
                if isFirstLoad {
                    isFirstLoad = false
                    await viewModel.getStartModule()
                }
                else {
                    await viewModel.updateModule()
                }
            }
        }
    }
}

//#Preview {
//    EditModuleView()
//}

#Preview("with data") {
    let modulePreload = ModulePreload(name: "Module 1", authorId: "1", isPublic: false)
    PreviewWrapper() {
        EditModuleView(modulePreload: modulePreload, isQuickModule: false)
    }
}
