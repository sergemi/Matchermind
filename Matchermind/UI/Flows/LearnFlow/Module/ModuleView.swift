//
//  ModuleView.swift
//  Matchermind
//
//  Created by sergemi on 25/06/2025.
//

import SwiftUI

struct ModuleView: View {
    @Environment(AppRouter.self) var router
    @Environment(AuthService.self) var authService
    @Environment(DataManager.self) var dataMgr
    
    let modulePreload: ModulePreload
    
    var body: some View {
        ModuleContentView(modulePreload: modulePreload,
                          router: router,
                          authService: authService,
                          dataMgr: dataMgr)
    }
}

struct ModuleContentView: View {
    @State private var viewModel: ModuleViewModel
    
    init(modulePreload: ModulePreload, router: AppRouter, authService: AuthService, dataMgr: DataManager) {
        _viewModel = State(initialValue: ModuleViewModel(modulePreload: modulePreload,
                                                         router: router,
                                                         authService: authService,
                                                         dataMgr: dataMgr))
    }
    
    var body: some View {
        VStack {
            if let module = viewModel.module {
                Text("Module loaded")
                Text(module.details)
            }
            else {
                ProgressView()
            }
        }
        .navigationTitle(viewModel.title)
        .task() {
            do {
                try await viewModel.loadModule()
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

//#Preview {
//    withMockDataEnvironment {
//        ModuleView()
//    }
//}
