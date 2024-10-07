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
    @State var learnNavigationPath = NavigationPath()

    
    @ViewBuilder func learnFlow() -> some View {
        NavigationStack(path: $learnNavigationPath) {
            MainLearnView()
        }
        .navigationDestination(for: NavLink.self, destination: linkDestination)
    }
    
    @ViewBuilder private func linkDestination(link: NavLink) -> some View {
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
