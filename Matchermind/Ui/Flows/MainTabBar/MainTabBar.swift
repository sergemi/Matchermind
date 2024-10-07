//
//  MainTabBar.swift
//  Matchermind
//
//  Created by sergemi on 02.10.2024.
//

import SwiftUI

struct MainTabBar: View {
    @EnvironmentObject private var coordinator: Coordinator
    var body: some View {
        TabView {
            NavigationStack(path: $coordinator.learnNavigationPath) {
                coordinator.learnFlow()
            }
            .tabItem{
                TabItem(image: Image(systemName: "book"),
                        caption: "Learn")
            }
            
            NavigationStack(path: $coordinator.quickAddNavigationPath) {
                coordinator.quickAddFlow()
                
            }
            .tabItem {
                TabItem(image: Image(systemName: "plus.message"),
                        caption: "Quick add")
            }
            
            NavigationStack(path: $coordinator.editNavigationPath) {
                coordinator.editFlow()
            }
            .tabItem{
                TabItem(image: Image(systemName: "wrench.and.screwdriver.fill"),
                        caption: "Edit")
            }
        }
    }
}

#Preview {
    MainTabBar()
}
