//
//  AuthFlow.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import SwiftUI

enum AuthFlowLink: Hashable {
    case signIn
    case signUp
}

struct AuthFlowView: View {
    @EnvironmentObject var router: AppRouter
    
    let closeAction: () -> Void // TODO: remove debug

    var body: some View {
        NavigationStack(path: $router.authPath) {
            SignInView()
                .navigationDestination(for: AuthFlowLink.self) { link in
                    switch link {
                    case .signIn:
                        SignInView()
                    case .signUp:
                        SignUpView()
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
