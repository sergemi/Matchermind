//
//  LessonsListViewModel.swift
//  MyRouter
//
//  Created by sergemi on 03/05/2025.
//

import Foundation
import Combine

final class LessonsListViewModel: DataViewModel {
    var title = "Lessons"
    
    var lessons: [MocLesson] {
        dataMgr.lessons
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    override init(errorMgr: ErrorManager?, router: AppRouter, authService: AuthService,  dataMgr: DataManager) {
        super.init(errorMgr: errorMgr, router: router, authService: authService, dataMgr: dataMgr)
        
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
        router.doLogin()
    }
    
    func testProfile() {
        router.showProfile()
    }
}
