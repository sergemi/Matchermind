//
//  LessonsListViewModel.swift
//  MyRouter
//
//  Created by sergemi on 03/05/2025.
//

import Foundation
import Combine

final class LessonsListViewModel: DataViewModel {
    @Published var title = "Lessons"
    
//    @Published var lessons: [MocLesson] = []
    var lessons: [MocLesson] {
        dataMgr.lessons
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    override init(router: AppRouter, authService: AuthService,  dataMgr: DataManager) {
        super.init(router: router, authService: authService, dataMgr: dataMgr)
        
//        dataMgr.$lessons
//            .receive(on: DispatchQueue.main)
//            .assign(to: &$lessons)
        
        Task {
            try await dataMgr.fetchLessons()
        }
    }
    
    func startLesson(id: String) {
        router.navigate(to: .learn(.startLesson(id: id)))
    }
    
    func editLesson(id: String) {
        router.navigate(to: .edit(.editLesson(id: id)))
    }
    
    func testLogin() {
        //        router.navigate(to: .auth(.login))
        router.doLogin()
    }
    
    func testProfile() {
        router.showProfile()
    }
}
