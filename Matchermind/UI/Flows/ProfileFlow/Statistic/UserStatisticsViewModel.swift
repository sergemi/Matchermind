//
//  DetailedProfileViewModel.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import Foundation

final class UserStatisticsViewModel: AuthViewModel {
    @Published var title = "Statistics"
    
//    private var router: AppRouter
//    
//    init(router: AppRouter) {
//        self.router = router
//    }
    
    func detailed() {
        print("detailed")
    }
    
    func close() {
        router.isShowingProfile = false
    }
}
