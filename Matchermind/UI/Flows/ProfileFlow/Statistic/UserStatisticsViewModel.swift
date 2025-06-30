//
//  DetailedProfileViewModel.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import Foundation

final class UserStatisticsViewModel: DataViewModel {
    let title = "Statistics"
    
    func detailed() {
        print("detailed")
    }
    
    func close() {
        router.isShowingProfile = false
    }
}
