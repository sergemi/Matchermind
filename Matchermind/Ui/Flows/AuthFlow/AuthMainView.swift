//
//  AuthMainView.swift
//  Matchermind
//
//  Created by sergemi on 05.10.2024.
//

import SwiftUI

struct AuthMainView<AuthServiceProxy: AuthServiceProtocol>: View {
    var body: some View {
        NavigationStack {
//            Text("TODO")
            SignInView<AuthServiceProxy>()
        }
    }
}

//#Preview {
//    let mocAuth = MockAuthService.initWithMockUser(loginned: true)
//    let errorManager = ErrorManager()
//    
//    return AuthMainView<MockAuthService>()
//        .environmentObject(mocAuth)
//        .environmentObject(errorManager)
//}
