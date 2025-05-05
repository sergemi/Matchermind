//
//  Lesson.swift
//  MyRouter
//
//  Created by sergemi on 03/05/2025.
//

import Foundation

struct MocLesson: Identifiable, Hashable {
    let id: String
    let name: String
    
    init (name: String, id:String = UUID().uuidString) {
        self.id = id
        self.name = name
    }
}
