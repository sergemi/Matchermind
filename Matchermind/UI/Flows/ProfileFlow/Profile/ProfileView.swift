//
//  BaseProfileView.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import SwiftUI

struct ProfileView: View {
    @Environment(AppRouter.self) var router
    @Environment(AuthService.self) var authService
    @Environment(ErrorManager.self) var errorMgr
    @Environment(DataManager.self) var dataMgr
    
    var body: some View {
        BaseProfileContentView(errorMgr: errorMgr,
                               router: router,
                               authService: authService,
                               dataMgr: dataMgr)
    }
}

struct BaseProfileContentView: View {
    @State private var viewModel: ProfileViewModel
    
    init(errorMgr: ErrorManager?, router: AppRouter, authService: AuthService, dataMgr: DataManager) {
        _viewModel = State(initialValue: ProfileViewModel(errorMgr: errorMgr,
                                                          router: router,
                                                          authService: authService, dataMgr: dataMgr))
    }
    
    var body: some View {
        VStack {
            Text("Base profile content")
            //            HStack {
            let id = viewModel.authService.user?.id ?? "N/A"
            let email = viewModel.authService.user?.email ?? "N/A"
            Text("id: \( id)")
            Text("email: \( email)")
            //            }
            Divider()
            if viewModel.authService.user != nil {
                UserProfileImageView(size: 150,
                                     editable: true)
            }
            
            Divider()
            VStack(spacing: 10) {
                Button("Statistics") {
                    viewModel.detailed()
                }
                if let quickModule = viewModel.dataMgr.quickModule {
                    Button("Edit quick module") {
                        viewModel.editQuickModule(preload:  quickModule.modulePreload)
                    }
                }
            }
            Spacer()
            Button("Logout", role: .destructive) {
                viewModel.logout()
            }
        }
        .navigationBarTitle(viewModel.title)
    }
}

#Preview {
    withMockDataEnvironment {
        ProfileView()
    }
}
