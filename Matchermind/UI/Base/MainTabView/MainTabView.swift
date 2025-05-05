//
//  MainTabView.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject private var router: AppRouter
    
    var body: some View {
        MainTabViewContentView(viewModel: MainTabViewModel(router: router))
    }
}

struct MainTabViewContentView: View {
    @StateObject var viewModel: MainTabViewModel
    
    var body: some View {
        TabView(selection: $viewModel.router.selectedTab) {
            ForEach(viewModel.tabs) { tab in
                if let tabItemData = viewModel.tabsItemData[tab] {
                    viewModel.tabView(tab)
                        .tabItem { TabItem(image: Image(imageType: tabItemData.image),
                                           caption: tabItemData.caption) }
                        .tag(tab)
                    
                }
            }
        }
    }
}

#Preview {
    let dataMgr: DataManager = MocDataManager()
    let router = AppRouter()
    
    return MainTabView()
        .environmentObject(router)
        .environmentObject(dataMgr)
}
