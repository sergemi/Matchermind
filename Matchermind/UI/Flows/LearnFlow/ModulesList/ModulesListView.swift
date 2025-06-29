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
    
    var body: some View {
        ModulesListContentView(viewModel: ModulesListViewModel(router: router,
                                                              authService: authService,
                                                              dataMgr: dataMgr))
    }
}

struct ModulesListContentView: View {
    @StateObject var viewModel: ModulesListViewModel
    
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
