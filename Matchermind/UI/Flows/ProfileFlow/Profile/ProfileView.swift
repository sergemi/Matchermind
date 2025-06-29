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
    
    var body: some View {
        BaseProfileContentView(viewModel: ProfileViewModel(router: router,
                                                           authService: authService))
    }
}

struct BaseProfileContentView: View {
    @State var viewModel: ProfileViewModel
    
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
            if let currentUser = viewModel.authService.user { // TODO: remove ?
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
