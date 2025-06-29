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
    
    var body: some View {
        DetailedProfileContentView(viewModel: UserStatisticsViewModel(router: router,
                                                                      authService: authService))
    }
}

struct DetailedProfileContentView: View {
    @State var viewModel: UserStatisticsViewModel
    
    var body: some View {
        VStack {
            Text("Detailed profile content")
        }
        .navigationBarTitle(viewModel.title)
    }
}

#Preview {
    withMockEnvironment {
        UserStatisticsView()
    }
}
