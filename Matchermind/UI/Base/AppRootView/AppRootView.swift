import SwiftUI

struct AppRootView: View {
    @StateObject private var router = AppRouter()
    @StateObject private var dataMgr: DataManager = FirebaseDataManager()
    @StateObject private var errorManager = ErrorManager()
    
    @StateObject var authService = AuthService(service:
                                                //                                                MockAuthService.initWithMockUser(loginned: true)
                                               FirebaseAuthService()
    )
    @StateObject var viewModel = AppRootViewModel()
    
    var body: some View {
        ZStack {
            MainTabView()
                .environmentObject(dataMgr)
                .environmentObject(router)
            
            
                .overlay(alignment: .topTrailing) {
                    if let currentUser = authService.user { // TODO: remove?
                        
                        UserProfileImageView(size: 44) {
                            router.showProfile()
                        }
                        .padding()
                    }
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
                    .environmentObject(errorManager) // TODO: is it necessary?
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
            }
        }
        .environmentObject(authService)
        .environmentObject(errorManager)
        .withErrorAlert(errorManager: errorManager)
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

