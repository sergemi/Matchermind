//
//  FirebaseDataManager.swift
//  Matchermind
//
//  Created by sergemi on 30/06/2025.
//

import Foundation

@Observable
class FirebaseDataManager: DataManager {
    convenience init() {
        let dataService = FirebaseDataService()
        self.init(dataService: dataService)
    }
}
