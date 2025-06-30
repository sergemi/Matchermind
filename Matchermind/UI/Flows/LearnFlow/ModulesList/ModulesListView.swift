//
//  ModulesListView.swift
//  Matchermind
//
//  Created by sergemi on 25/06/2025.
//

import SwiftUI

struct ModulesListView: View {
    @Environment(AppRouter.self) var router
    @Environment(AuthService.self) var authService
    @Environment(DataManager.self) var dataMgr
    @Environment(ErrorManager.self) var errorMgr
    
    var body: some View {
        ModulesListContentView(errorMgr: errorMgr,
                               router: router,
                               authService: authService,
                               dataMgr: dataMgr)
    }
}

struct ModulesListContentView: View {
    @State var viewModel: ModulesListViewModel
    
    init(errorMgr: ErrorManager?, router: AppRouter, authService: AuthService, dataMgr: DataManager) {
        _viewModel = State(initialValue: ModulesListViewModel(errorMgr: errorMgr,
                                                              router: router,
                                                              authService: authService,
                                                              dataMgr: dataMgr))
    }
    
    var body: some View {
        VStack {
            if let quickModule = viewModel.quickModule {
                ModuleListRow(modulePreload: quickModule)
            }
            
            HStack {
                Text("Modules:")
                    .font(.title2)
                
                Spacer()
            }
            if viewModel.modules.isEmpty {
                Text("No modules available")
                Spacer()
            }
            else {
                ScrollView{
                    LazyVStack(alignment: .leading, spacing: 8) {
                        ForEach(viewModel.modules) { module in
                            Button {
                                viewModel.selectModule(module)
                            } label: {
                                ModuleListRow(modulePreload: module)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        //        .padding(.top, 8)
        .padding()
        .navigationTitle(viewModel.title)
    }
}

#Preview {
    withMockDataEnvironment {
        ModulesListView()
    }
}
