//
//  Coordinator.swift
//  Matchermind
//
//  Created by sergemi on 07.10.2024.
//

import SwiftUI

//@Observable class Coordinator {
//    var learnNavigationPath = NavigationPath()



final class Coordinator<AuthServiceProxy: AuthServiceProtocolOld>: ObservableObject {
    enum NavigationFlow: String, Hashable {
        case learn
        case quickAdd
        case edit
        case auth
    }
    
    struct TabItemData {
        let image: Image.ImageType
        let caption: String
    }
    
    private let tabsItemData: [NavigationFlow: TabItemData] = [
        .learn : TabItemData(image: .system("book"), caption: "Learn"),
        .quickAdd : TabItemData(image: .system("plus.message"), caption: "Quick add"),
        .edit : TabItemData(image: .system("wrench.and.screwdriver.fill"), caption: "Edit"),
    ]
    
    @Published var learnNavigationPath = NavigationPath()
    @Published var quickAddNavigationPath = NavigationPath()
    @Published var editNavigationPath = NavigationPath()
    
    @Published var selectedTab: NavigationFlow = .learn
    
    @ViewBuilder func flowView(_ flow: NavigationFlow) -> some View {
        switch(flow) {
        case .learn:
            MainLearnView<AuthServiceProxy>()
                .navigationDestination(for: NavLink.self,
                                       destination: linkDestination)
            
        case .quickAdd:
            MainQuickAddView<AuthServiceProxy>()
                .navigationDestination(for: NavLink.self,
                                       destination: linkDestination)
            
        case .edit:
            MainEditView<AuthServiceProxy>()
                .navigationDestination(for: NavLink.self,
                                       destination: linkDestination)
            
        default:
            fatalError("Invalid key")
        }
    }
    
    func flowTabItem(_ flow: NavigationFlow) -> some View {
        guard let data = tabsItemData[flow] else {
            fatalError()
        }
        return TabItem(image: Image(imageType: data.image),
                       caption: data.caption)
        
    }
    
//    func flowTabTag(_ flow: NavigationFlow) ->
    
    @ViewBuilder private func linkDestination(link: NavLink) -> some View {
        switch link {
        case .mainLearnView:
            MainLearnView<AuthServiceProxy>()
            
        case .resumeLearnView:
            ResumeLearnView()
            
        case .startNewLearnView:
            StartNewLearnView()
            
        case .profileView:
            ProfileView<AuthServiceOld>() // TODO: implement template
            
        default:
            EmptyView()
        }
    }
    
    // Learn flow
    
    func resumeLearn() {
        print("coordinator.resumeLearn")
        learnNavigationPath.append(NavLink.resumeLearnView)
    }
}
