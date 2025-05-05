//
//  EditLessonsList.swift
//  MyRouter
//
//  Created by sergemi on 03/05/2025.
//

import SwiftUI

struct EditLessonsListView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var dataMgr: DataManager
    
    var body: some View {
        EditLessonsListContentView(viewModel: EditLessonsListViewModel(router: router,
                                                                       authService: authService,
                                                                       dataMgr: dataMgr))
    }
}

struct EditLessonsListContentView: View {
    @StateObject var viewModel: EditLessonsListViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.lessons) { lesson in
                Button(lesson.name) {
                    viewModel.editLesson(id: lesson.id)
                }
            }
        }
        .navigationTitle(viewModel.title)
    }
}

#Preview { // TODO: Why empty in preview ?
    withMockDataEnvironment {
        EditLessonsListView()
    }
}
