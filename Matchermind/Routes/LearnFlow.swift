//
//  LearnFlow.swift
//  MyRouter
//
//  Created by sergemi on 03/05/2025.
//

import SwiftUI

enum LearnFlowLink: Hashable {
    case lessonsList //TODO: remove
    case startLesson(id: String) //TODO: remove
    case modulesList
    case module(preload: ModulePreload)
}

struct LearnFlowView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var dataMgr: DataManager
    
    var body: some View {
        NavigationStack(path: $router.learnPath) {
            //            LessonsListView()
            ModulesListView()
                .navigationDestination(for: LearnFlowLink.self) { link in
                    switch link {
                    case .lessonsList:
                        LessonsListView()
                        
                    case .startLesson(let lessonId):
                        StartLessonView(lessonId: lessonId)
                        
                    case .modulesList:
                        ModulesListView()
                        
                    case .module(let preload):
                        ModuleView(modulePreload: preload)
                    }
                }
        }
    }
}
