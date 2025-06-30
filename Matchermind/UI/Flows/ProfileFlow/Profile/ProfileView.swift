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
    
    var body: some View {
        BaseProfileContentView(errorMgr: errorMgr,
                               router: router,
                               authService: authService)
    }
}

struct BaseProfileContentView: View {
    @State private var viewModel: ProfileViewModel
    
    init(errorMgr: ErrorManager?, router: AppRouter, authService: AuthService) {
        _viewModel = State(initialValue: ProfileViewModel(errorMgr: errorMgr,
                                                          router: router,
                                                          authService: authService))
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
            Button("Statistics") {
                viewModel.detailed()
            }
            Spacer()
            Button("Logout") {
                viewModel.logout()
            }
        }
        .navigationBarTitle(viewModel.title)
    }
}

#Preview {
    withMockEnvironment {
        ProfileView()
    }
}
