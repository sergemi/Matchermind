//
//  Coordinator.swift
//  Matchermind
//
//  Created by sergemi on 07.10.2024.
//

import SwiftUI

//@Observable class Coordinator {
//    var learnNavigationPath = NavigationPath()

class Coordinator: ObservableObject {
    @Published var learnNavigationPath = NavigationPath()
    
    @ViewBuilder func linkDestination(link: NavLink) -> some View {
        switch link {
        case .mainLearnView:
            MainLearnView()
            
        case .resumeLearnView:
            ResumeLearnView()
            
        case .startNewLearnView:
            StartNewLearnView()
            
        default:
            EmptyView()
        }
    }
}
