//
//  ProfileView.swift
//  Matchermind
//
//  Created by sergemi on 03.10.2024.
//

import SwiftUI

struct ProfileView<AuthServiceProxy>: View where AuthServiceProxy: AuthServiceProtocol {
    @EnvironmentObject var authService: AuthServiceProxy
    
    var body: some View {
        VStack {
            Text("User: \(authService.user?.email)")
            Spacer()
            Button {
                Task {
                    try authService.logOut()
                }
            } label: {
                Text("Logout")
            }
        }
    }
}

#Preview {
    let mocAuth = MockAuthService(email: "aaa@gmail.com")
    
    return ProfileView<MockAuthService>()
        .environmentObject(mocAuth)
}
