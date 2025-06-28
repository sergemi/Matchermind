import SwiftUI

struct AppRootView: View {
    @State private var router = AppRouter()
    @State private var errorManager = ErrorManager()
    
    @State private var authService = AuthService(service:
                                                    //                                                MockAuthService.initWithMockUser(loginned: true)
                                                 FirebaseAuthService()
    )
    @StateObject private var dataMgr: DataManager = FirebaseDataManager()
    
    @StateObject var viewModel = AppRootViewModel()
    
    var body: some View {
        ZStack {
            MainTabView()
                .environmentObject(dataMgr)
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
                        try await dataMgr.removeUser()
                    }
                    catch {
                        print("Error setting user: \(error)")
                    }
                }
            }
        }
    }
}

