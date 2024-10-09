//
//  ProfileNavigationBarButton.swift
//  Matchermind
//
//  Created by sergemi on 07.10.2024.
//

import SwiftUI

struct ProfileNavigationBarButton: View {
    var body: some View {
        NavigationLink {
            ProfileView<AuthService>()
        } label: {
            Label("User Profile", systemImage: "person.crop.circle")
        }
    }
}

#Preview {
    ProfileNavigationBarButton()
}
