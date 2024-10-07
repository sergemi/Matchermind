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
                MainLearnView()
                    .navigationDestination(for: NavLink.self,
                                           destination: coordinator.linkDestination)
            }
            
//            .navigationDestination(for: NavLink.self,
//                                   destination: coordinator.linkDestination)
            
//            coordinator.learnFlow()
            .tabItem{
                TabItem(image: Image(systemName: "book"),
                        caption: "Learn")
            }
            
            NavigationStack {
                Text("Flow add")
                
            }
            .tabItem {
                TabItem(image: Image(systemName: "plus.message"),
                        caption: "Quick add")
            }
            
            NavigationStack {
                Text("Flow edit")
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
