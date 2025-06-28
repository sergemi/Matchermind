//
//  LessonsListView.swift
//  MyRouter
//
//  Created by sergemi on 03/05/2025.
//

import SwiftUI

struct LessonsListView: View {
    @Environment(AppRouter.self) var router
    @Environment(AuthService.self) var authService
    @EnvironmentObject var dataMgr: DataManager
    
    var body: some View {
        LessonsListContentView(viewModel: LessonsListViewModel(router: router,
                                                               authService: authService,
                                                               dataMgr: dataMgr))
    }
}

struct LessonsListContentView: View {
    @StateObject var viewModel: LessonsListViewModel

    var body: some View {
        VStack {
            ForEach(viewModel.lessons) { lesson in
                Button(lesson.name) {
//                    router.navigate(to: .learn(.startLesson(id: lesson.id)))
                    viewModel.startLesson(id: lesson.id)
//                    viewModel.editLesson(id: lesson.id)
                }
            }
            
            Divider()
            
            Button("Go to Login") {
                viewModel.testLogin()
            }
            
            Button("Profile") {
                viewModel.testProfile()
            }
        }
        .navigationTitle(viewModel.title)
    }
}

#Preview {
    withMockDataEnvironment{
        LessonsListView()
    }
}
