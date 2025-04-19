//
//  ProfileNavigationBarButton.swift
//  Matchermind
//
//  Created by sergemi on 07.10.2024.
//

import SwiftUI

struct ProfileNavigationBarButton<AuthServiceProxy: AuthServiceProtocol>: View {
    var body: some View {
        NavigationLink {
            ProfileView<AuthServiceProxy>()
        } label: {
            Label("User Profile", systemImage: "person.crop.circle")
        }
    }
}

#Preview {
    ProfileNavigationBarButton<MockAuthService>()
}
