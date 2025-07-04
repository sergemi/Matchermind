//
//  MainTabView.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import SwiftUI

struct MainTabView: View {
    @Environment(AppRouter.self) private var router
    
    var body: some View {
        MainTabViewContentView(router: router)
    }
}

struct MainTabViewContentView: View {
    @Environment(AppRouter.self) private var router
    @State var viewModel: MainTabViewModel
    
    init(router: AppRouter) {
        _viewModel = State(initialValue: MainTabViewModel(router: router))
    }
    
    var body: some View {
        @Bindable var router = router
        
        TabView(selection: $router.selectedTab) {
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
    withMockDataEnvironment {
        MainTabView()
    }
}
