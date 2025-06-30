//
//  MocDataManager.swift
//  Matchermind
//
//  Created by sergemi on 30/06/2025.
//

import Foundation

class MocDataManager: DataManager {
    convenience init(testDelayMax: Int = 0, withData: Bool = false) {
        let dataService = MocDataService(testDelayMax: testDelayMax, withData: withData)
        self.init(dataService: dataService)
    }
}
