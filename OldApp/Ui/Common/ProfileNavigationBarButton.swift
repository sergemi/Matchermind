//
//  ProfileNavigationBarButton.swift
//  Matchermind
//
//  Created by sergemi on 07.10.2024.
//

import SwiftUI

struct ProfileNavigationBarButton<AuthServiceProxy: AuthServiceProtocolOld>: View {
    var body: some View {
        NavigationLink {
            Text("Stub")
        } label: {
            Label("User Profile", systemImage: "person.crop.circle")
        }
    }
}

#Preview {
    ProfileNavigationBarButton<MockAuthServiceOld>()
}
