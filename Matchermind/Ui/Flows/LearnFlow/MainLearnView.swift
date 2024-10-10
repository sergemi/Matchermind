//
//  MainLearnView.swift
//  Matchermind
//
//  Created by sergemi on 03.10.2024.
//

import SwiftUI

struct MainLearnView: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        VStack {
            NavigationLink {
                ResumeLearnView()
            } label: {
                Text("Resume last")
            }
            
            Button {
                coordinator.resumeLearn()
            } label: {
                Text("Button resume learn")
            }

            
            NavigationLink(value: NavLink.resumeLearnView) {
                Text("Test link")
            }
            
            NavigationLink(value: NavLink.profileView) {
                Text("Test profile")
            }
            
            NavigationLink {
                StartNewLearnView()
            } label: {
                Text("Start new")
            }
        }
        .navigationTitle("Learn main")
        
        .toolbar {
            ProfileNavigationBarButton()
        }
    }
}

#Preview {
    NavigationStack {
        MainLearnView()
    }
}
