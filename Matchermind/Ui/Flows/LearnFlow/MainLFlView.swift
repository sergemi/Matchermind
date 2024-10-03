//
//  MainLFlView.swift
//  Matchermind
//
//  Created by sergemi on 03.10.2024.
//

import SwiftUI

struct MainLFlView: View {
    var body: some View {
            VStack {
                Text("Learn")
        }
        .toolbar {
            NavigationLink {
                ProfileView<AuthService>()
            } label: {
                Label("User Profile", systemImage: "person.crop.circle")
            }
        }
    }
}

#Preview {
    NavigationStack {
        MainLFlView()
    }
}
