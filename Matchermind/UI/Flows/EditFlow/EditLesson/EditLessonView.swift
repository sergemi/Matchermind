//
//  EditLessonView.swift
//  MyRouter
//
//  Created by sergemi on 03/05/2025.
//

import SwiftUI

struct EditLessonView: View {
    @Environment(AppRouter.self) var router
    @Environment(AuthService.self) var authService
    @Environment(DataManager.self) var dataMgr
    
    let lessonId: String
    
    var body: some View {
        EditLessonContentView(viewModel: EditLessonViewModel(router: router,
                                                             authService: authService,
                                                             dataMgr: dataMgr,
                                                             lessonId: lessonId))
    }
}

struct EditLessonContentView: View {
    @StateObject var viewModel: EditLessonViewModel
    
    var body: some View {
        VStack {
            TextField("Name", text: $viewModel.name)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button("Save") {
                viewModel.saveChanges()
            }
//            .disabled(!viewModel.canSave)
            .disabled(!viewModel.isModified)
        }
        .navigationTitle(viewModel.title)
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
//    return EditLessonView(lessonId: lesson.id)
//        .environmentObject(dataMgr)
//        .environmentObject(router)
//        .environmentObject(mockWrapper)
//}
