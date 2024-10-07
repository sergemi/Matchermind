//
//  MainLearnView.swift
//  Matchermind
//
//  Created by sergemi on 03.10.2024.
//

import SwiftUI

struct MainLearnView: View {
    var body: some View {
        VStack {
            NavigationLink {
                ResumeLearnView()
            } label: {
                Text("Resume last")
            }
            
            NavigationLink(value: NavLink.resumeLearnView) {
                Text("Test link")
            }
            
            NavigationLink {
                StartNewLearnView()
            } label: {
                Text("Start new")
            }
        }
        .navigationTitle("Learn main")
        
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
        MainLearnView()
    }
}
