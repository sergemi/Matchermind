//
//  StartLessonViewModel.swift
//  MyRouter
//
//  Created by sergemi on 03/05/2025.
//

import Foundation
import Combine

final class StartLessonViewModel: DataViewModel {
    var title = "Start lesson"
    var lesson: MocLesson?
    
    private var cancellables = Set<AnyCancellable>()
    
    init (errorMgr: ErrorManager?, router: AppRouter, authService: AuthService, dataMgr: DataManager, lessonId: String) {
        super.init(errorMgr: errorMgr, router: router, authService: authService, dataMgr: dataMgr)
        
        self.lesson = self.dataMgr.lessons.first(where: {$0.id == lessonId})
    }
    
    func editLesson(id: String) {
        router.navigate(to: .edit(.editLesson(id: id)))
    }
}
