//
//  ModuleView.swift
//  Matchermind
//
//  Created by sergemi on 25/06/2025.
//

import SwiftUI

struct ModuleView: View {
    @Environment(AppRouter.self) var router
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var dataMgr: DataManager
    
    let modulePreload: ModulePreload
    
    var body: some View {
        ModuleContentView(viewModel: ModuleViewModel(modulePreload: modulePreload,
                                                     module: Binding(
                                                        get: { dataMgr.currentModule },
                                                        set: { dataMgr.currentModule = $0 }
                                                     ),
                                                     router: router,
                                                     authService: authService,
                                                     dataMgr: dataMgr))
    }
}

struct ModuleContentView: View {
    @StateObject var viewModel: ModuleViewModel
    
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
    }
}

//#Preview {
//    withMockDataEnvironment {
//        ModuleView()
//    }
//}
