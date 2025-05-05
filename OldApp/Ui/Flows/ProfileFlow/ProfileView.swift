//
//  ProfileView.swift
//  Matchermind
//
//  Created by sergemi on 03.10.2024.
//

import SwiftUI

struct ProfileView<AuthServiceProxy:AuthServiceProtocolOld>: View {
    @EnvironmentObject var authService: AuthServiceProxy
    
    var body: some View {
        VStack {
            Text("User: \(authService.user?.email)")
            Spacer()
            Button {
                Task {
                    try authService.signOut()
                }
            } label: {
                Text("Logout")
            }
        }
        .onAppear() { // TODO: remove
            print("ProfileView.onAppear")
        }
    }
}

#Preview {
    let mocAuth = MockAuthServiceOld.initWithMockUser(loginned: true)
    
    return ProfileView<MockAuthServiceOld>()
        .environmentObject(mocAuth)
}
