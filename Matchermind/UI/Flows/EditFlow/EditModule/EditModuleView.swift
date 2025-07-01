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
    
    init(modulePreload: ModulePreload?, isQuickModule: Bool, errorMgr: ErrorManager?, router: AppRouter, authService: AuthService, dataMgr: DataManager) {
        _viewModel = State(initialValue: EditModuleViewModel(modulePreload: modulePreload,
                                                             isQuickModule: isQuickModule,
                                                             errorMgr: errorMgr,
                                                             router: router,
                                                             authService: authService,
                                                             dataMgr: dataMgr))
    }
    
    var body: some View {
        VStack {
            if let module = viewModel.currentModule {
                Text("Module loaded")
                Text(module.details)
            }
            else {
                ProgressView()
            }
        }
        .navigationTitle(viewModel.title)
        .task() {
            await viewModel.getStartModule()
        }
    }
}

//#Preview {
//    EditModuleView()
//}
