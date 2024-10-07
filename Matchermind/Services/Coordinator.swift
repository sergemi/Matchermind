//
//  Coordinator.swift
//  Matchermind
//
//  Created by sergemi on 07.10.2024.
//

import SwiftUI

//@Observable class Coordinator {
//    var learnNavigationPath = NavigationPath()

final class Coordinator: ObservableObject {
    @Published var learnNavigationPath = NavigationPath()
    @Published var quickAddNavigationPath = NavigationPath()
    @Published var editNavigationPath = NavigationPath()
    
    @ViewBuilder func learnFlow() -> some View {
        MainLearnView()
            .navigationDestination(for: NavLink.self,
                                   destination: linkDestination)
    }
    
    @ViewBuilder func quickAddFlow() -> some View {
        MainQuickAddView()
            .navigationDestination(for: NavLink.self,
                                   destination: linkDestination)
    }
    
    @ViewBuilder func editFlow() -> some View {
        MainEditView()
            .navigationDestination(for: NavLink.self,
                                   destination: linkDestination)
    }
    
    @ViewBuilder private func linkDestination(link: NavLink) -> some View {
        switch link {
        case .mainLearnView:
            MainLearnView()
            
        case .resumeLearnView:
            ResumeLearnView()
            
        case .startNewLearnView:
            StartNewLearnView()
            
        case .profileView:
            ProfileView<AuthService>() // TODO: implement template
            
        default:
            EmptyView()
        }
    }
}
