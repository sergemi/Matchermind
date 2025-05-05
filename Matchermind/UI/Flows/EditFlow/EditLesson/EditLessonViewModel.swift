//
//  EditLessonViewModel.swift
//  MyRouter
//
//  Created by sergemi on 03/05/2025.
//

import Foundation
import Combine

final class EditLessonViewModel: DataViewModel {
    @Published var title = "Edit lesson"
    
    var lesson: MocLesson?
    @Published var name: String
    @Published var canSave: Bool = false
    
    var isModified: Bool {
        let previousName = lesson?.name ?? ""
        let ret = name.trimmingCharacters(in: .whitespacesAndNewlines) != previousName
        
        print("!!!!!! isModified: \(ret)")
        
        return ret
        }
    
    private var cancelables = Set<AnyCancellable>()
    
    init (router: AppRouter, authService: AuthService, dataMgr: DataManager, lessonId: String) {
        self.name = lesson?.name ?? ""
        
        super.init(router: router, authService: authService, dataMgr: dataMgr)
        
        self.lesson = self.dataMgr.lessons.first(where: {$0.id == lessonId})
    }
    
    func saveChanges() {
        guard var lesson = lesson else { return }
        let changedLesson = MocLesson(name: self.name, id: lesson.id)
        
        if let index = dataMgr.lessons.firstIndex(where: { $0.id == lesson.id }) {
            dataMgr.lessons[index] = changedLesson
            lesson = changedLesson
        }
    }
}
