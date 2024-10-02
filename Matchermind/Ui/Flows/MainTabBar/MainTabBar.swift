//
//  MainTabBar.swift
//  Matchermind
//
//  Created by sergemi on 02.10.2024.
//

import SwiftUI

struct MainTabBar: View {
    var body: some View {
        TabView {
            Text("Flow learn")
                .tabItem{
                    TabItem(image: Image(systemName: "book"),
                            caption: "Learn")
                }
            
            Text("Flow add")
                .tabItem {
                    TabItem(image: Image(systemName: "plus.message"),
                            caption: "Quick add")
                }
            
            Text("Flow edit")
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
