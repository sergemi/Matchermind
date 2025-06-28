//
//  EditFlow.swift
//  MyRouter
//
//  Created by sergemi on 03/05/2025.
//

import SwiftUI

enum EditFlowLink: Hashable {
    case lessonsList
    case editLesson(id: String)
}

struct EditFlowView: View {
    @Environment(AppRouter.self) private var router
    
    var body: some View {
        @Bindable var router = router
        
        NavigationStack(path: $router.editPath) {
            EditLessonsListView()
                .navigationDestination(for: EditFlowLink.self) { link in
                    switch link {
                    case .lessonsList:
                        EditLessonsListView()
                    case .editLesson(let lessonId):
                        EditLessonView(lessonId: lessonId)
                    }
                }
        }
    }
}
