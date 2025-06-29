//
//  StartLessonView.swift
//  MyRouter
//
//  Created by sergemi on 03/05/2025.
//

import SwiftUI

struct StartLessonView: View {
    @Environment(AppRouter.self) var router
    @Environment(AuthService.self) var authService
    @Environment(DataManager.self) var dataMgr
    
    let lessonId: String
    
    var body: some View {
        StartLessonContentView(viewModel: StartLessonViewModel(router: router,
                                                               authService: authService,
                                                               dataMgr: dataMgr,
                                                               lessonId: lessonId)
        )
    }
}

struct StartLessonContentView: View {
    @StateObject var viewModel: StartLessonViewModel
    
    var body: some View {
        Text(viewModel.lesson?.name ?? "Unknown" )
            .navigationTitle(viewModel.title)
        
        Button("Edit") {
            guard let lessonId = viewModel.lesson?.id else { return }
            
            viewModel.editLesson(id: lessonId)
            
        }
    }
}

//#Preview {
//    let mockService = MockAuthService.initWithMockUser(loginned: true)
//    let mockWrapper = AuthService(service: mockService)
//    let dataMgr: DataManager = MocDataManager()
//    let router = AppRouter()
//    
//    let lesson = MocLesson(name: "Lesson for edit")
//    dataMgr.lessons.append(lesson)
//    
//    StartLessonView(lessonId: lesson.id)
//        .environmentObject(dataMgr)
//        .environment(router)
//        .environmentObject(mockWrapper)
//}
