//
//  WordPair.swift
//  Matchermind
//
//  Created by sergemi on 11.10.2024.
//

import Foundation

struct WordPair: Identifiable, Equatable, Codable {
    let id: String
    
    var target: String
    var translate: String
    var pronounce: String
    var notes: String
    
    init(id: String, target: String, translate: String, pronounce: String, notes: String) {
        self.id = id
        self.target = target
        self.translate = translate
        self.pronounce = pronounce
        self.notes = notes
    }
    
    init (target: String, translate: String, pronounce: String, notes: String) {
        self.init(id: UUID().uuidString,
                  target: target,
                  translate: translate,
                  pronounce: pronounce,
                  notes: notes)
    }
    
    init() {
        print("TODO: WordPair better init by concrete type")
        self.init(target: "", translate: "", pronounce: "", notes: "")
    }
}
