//
//  EditLessonsListViewModel.swift
//  MyRouter
//
//  Created by sergemi on 03/05/2025.
//

import Foundation
import Combine

final class EditLessonsListViewModel: DataViewModel {
    @Published var title = "Lessons to edit"
    
    @Published var lessons: [MocLesson] = []
    private var cancellables = Set<AnyCancellable>()
    
    override init(router: AppRouter, authService: AuthService,  dataMgr: DataManager) {
        super.init(router: router, authService: authService, dataMgr: dataMgr)
        
        dataMgr.$lessons
            .receive(on: DispatchQueue.main)
            .assign(to: &$lessons)
    }
    
    func editLesson(id: String) {
        router.navigate(to: .edit(.editLesson(id: id)))
    }
}
