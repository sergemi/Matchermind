//
//  MainTabBar.swift
//  Matchermind
//
//  Created by sergemi on 02.10.2024.
//

import SwiftUI

struct MainTabBar<AuthServiceProxy: AuthServiceProtocol>: View {
    @EnvironmentObject private var coordinator: Coordinator<AuthServiceProxy>
    var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            NavigationStack(path: $coordinator.learnNavigationPath) {
                coordinator.flowView(.learn)
            }
            .tabItem{
                coordinator.flowTabItem(.learn)
            }
            .tag(Coordinator<AuthServiceProxy>.NavigationFlow.learn)
            
            NavigationStack(path: $coordinator.quickAddNavigationPath) {
                coordinator.flowView(.quickAdd)
            }
            .tabItem {
                coordinator.flowTabItem(.quickAdd)
            }
            .tag(Coordinator<AuthServiceProxy>.NavigationFlow.quickAdd)
            
            NavigationStack(path: $coordinator.editNavigationPath) {
                coordinator.flowView(.edit)
            }
            .tabItem{
                coordinator.flowTabItem(.edit)
            }
            .tag(Coordinator<AuthServiceProxy>.NavigationFlow.edit)
        }
    }
}

#Preview {
    let coordinator = Coordinator<MockAuthService>()
    
    return MainTabBar<MockAuthService>()
        .environmentObject(coordinator)
}
