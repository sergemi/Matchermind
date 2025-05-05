import SwiftUI

struct AppRootView: View {
    @StateObject private var router = AppRouter()
    @StateObject private var dataMgr: DataManager = FirebaseDataManager()
    
    @StateObject var authService = AuthService(service:
                                                MockAuthService.initWithMockUser(loginned: true)
    )
    @StateObject var viewModel = AppRootViewModel()

    var body: some View {
        ZStack {
            MainTabView()
            .environmentObject(dataMgr)
            .environmentObject(router)
            
            .overlay(alignment: .topTrailing) {
                ProfileButton(size: 44) {
                    router.showProfile()
                }
                .padding()
            }
            
            .sheet(isPresented: $router.isShowingProfile) {
                ProfileFlowView()
                    .environmentObject(router)
            }
            
//            .sheet(isPresented: $router.isShowingProfile) {
//                ProfileFlowView()
//                    .environmentObject(router)
//            }

            if router.isShowingAuth {
                AuthFlowView(closeAction: router.closeAuth)
                    .environmentObject(router)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
            }
        }
        .environmentObject(authService)
        .task() {
            authService.$user.sink { user in
                router.isShowingAuth = user == nil
                if user == nil {
                    router.isShowingProfile = false
                }
            }
            .store(in: &viewModel.cancellables)
        }
    }
}

