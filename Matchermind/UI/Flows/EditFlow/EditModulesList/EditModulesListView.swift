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
    
    @State private var indexSetToDelete: IndexSet? = nil
    @State private var showDeleteConfirmation = false
    
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
                        .contentShape(Rectangle())
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
                List {
                    ForEach(viewModel.modules) { module in
                        Button {
                            viewModel.selectModule(module)
                        } label: {
                            EditModuleListRow(modulePreload: module)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .listRowInsets(.init())
                    }
                    .onDelete { indexSet in
                        indexSetToDelete = indexSet
                        showDeleteConfirmation = true
                    }
                }
                .scrollIndicators(.hidden) // TODO: remove?
                .listStyle(.plain)
                .confirmationDialog(
                    "Are you sure you want to delete this word?",
                    isPresented: $showDeleteConfirmation,
                    titleVisibility: .visible
                ) {
                    Button("Delete", role: .destructive) {
                        if let indexSetToDelete {
                            print("TODO: implement delete module")
//                            viewModel.modules.remove(atOffsets: indexSetToDelete)
                        }
                    }
                    Button("Cancel", role: .cancel) {
                        indexSetToDelete = nil
                    }
                }
            }
        }
        //        .padding(.top, 8)
        .padding()
        .navigationTitle(viewModel.title)
        .onAppear() {
            print("onAppear !!!")
            Task{
                await viewModel.updateModules()
            }
        }
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
