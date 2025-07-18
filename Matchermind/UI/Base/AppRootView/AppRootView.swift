import SwiftUI

struct AppRootView: View {
    @State private var router = AppRouter()
    @State private var errorManager = ErrorManager()
    
    @State private var authService = AuthService(service:
//                                                                                                    MockAuthService.initWithMockUser(loginned: true)
                                                 FirebaseAuthService()
    )
    @State private var dataMgr: DataManager =
//    MocDataManager(testDelayMax: 0,
//                   withData: true)
    FirebaseDataManager()
    
    @State var viewModel = AppRootViewModel()
    
    var body: some View {
        ZStack {
            MainTabView()
                .environment(dataMgr)
                .environment(router)
            
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
                        .environment(router)
                        .environment(dataMgr)
                }
            if router.isShowingAuth {
                AuthFlowView(closeAction: router.closeAuth)
                    .environment(router)
                    .environment(errorManager) // TODO: is it necessary?
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
            }
        }
        .environment(authService)
        .environment(errorManager)
        .withErrorAlert(errorManager: errorManager)
        .onChange(of: authService.user) { _, user in
            router.isShowingAuth = user == nil
            if user == nil {
                router.reset()
            }
            if let user = user {
                Task {
                    do {
                        try await dataMgr.setUser(user)
                    }
                    catch {
                        print("Error setting user: \(error)")
                    }
                }
            }
            else {
                router.isShowingProfile = false
                Task {
                    do {
                        try await dataMgr.resetUser()
                    }
                    catch {
                        print("Error setting user: \(error)")
                    }
                }
            }
        }
    }
}

