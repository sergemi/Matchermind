//
//  DetailedProfileView.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import SwiftUI

struct UserStatisticsView: View {
    @Environment(AppRouter.self) var router
    @Environment(AuthService.self) var authService
    @Environment(DataManager.self) var dataMgr
    
    var body: some View {
        DetailedProfileContentView(router: router,
                                   authService: authService,
                                   dataMgr: dataMgr)
    }
}

struct DetailedProfileContentView: View {
    @State private var viewModel: UserStatisticsViewModel
    
    init(router: AppRouter, authService: AuthService, dataMgr: DataManager) {
        _viewModel = State(initialValue: UserStatisticsViewModel(router: router,
                                                                 authService: authService,
                                                                 dataMgr: dataMgr))
    }
    
    var body: some View {
        VStack {
            Text("Detailed profile content")
        }
        .navigationBarTitle(viewModel.title)
    }
}

#Preview {
    withMockDataEnvironment {
        UserStatisticsView()
    }
}
