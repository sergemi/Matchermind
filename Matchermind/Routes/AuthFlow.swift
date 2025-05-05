//
//  AuthFlow.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import SwiftUI

enum AuthFlowLink: Hashable {
    case login
    case rerister
}

struct AuthFlowView: View {
    @EnvironmentObject var router: AppRouter
    
    let closeAction: () -> Void // TODO: remove debug

    var body: some View {
        NavigationStack(path: $router.authPath) {
            LoginView()
                .navigationDestination(for: AuthFlowLink.self) { link in
                    switch link {
                    case .login:
                        LoginView()
                    case .rerister:
                        RegisterView()
                    }
                }
            
//            VStack(spacing: 20) {
//                Text("Auth")
//                NavigationLink("Detail", destination: Text("Auth Detail"))
//                Button("Close") {
//                    closeAction()
//                }
//            }
//            .padding()
//            .navigationTitle("Auth")
        }
        .background(Color(.systemBackground).ignoresSafeArea())
    }
}
