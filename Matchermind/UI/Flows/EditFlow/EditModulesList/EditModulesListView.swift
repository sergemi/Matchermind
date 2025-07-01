//
//  EditModulesListView.swift
//  Matchermind
//
//  Created by sergemi on 25/06/2025.
//

import SwiftUI

struct EditModulesListView: View {
    @Environment(AppRouter.self) var router
    @Environment(AuthService.self) var authService
    @Environment(DataManager.self) var dataMgr
    @Environment(ErrorManager.self) var errorMgr
    
    var body: some View {
        EditModulesListContentView(errorMgr: errorMgr,
                               router: router,
                               authService: authService,
                               dataMgr: dataMgr)
    }
}

struct EditModulesListContentView: View {
    @State var viewModel: EditModulesListViewModel
    
    init(errorMgr: ErrorManager?, router: AppRouter, authService: AuthService, dataMgr: DataManager) {
        _viewModel = State(initialValue: EditModulesListViewModel(errorMgr: errorMgr,
                                                              router: router,
                                                              authService: authService,
                                                              dataMgr: dataMgr))
    }
    
    var body: some View {
        VStack {
            if let quickModule = viewModel.quickModule {
//                EditModuleListRow(modulePreload: quickModule)
                
                Button {
                    viewModel.selectModule(quickModule)
                } label: {
                    EditModuleListRow(modulePreload: quickModule)
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            EditModuleRowHeader(count: viewModel.modules.count) {
                viewModel.addModule()
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
                                EditModuleListRow(modulePreload: module)
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

//#Preview {
//    withMockDataEnvironment {
//        EditModulesListView()
//    }
//}

#Preview("with data") {
    PreviewWrapper() {
//    PreviewWrapper(loginned: false) {
        EditModulesListView()
    }
}
