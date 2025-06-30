//
//  PreviewWrapper.swift
//  Matchermind
//
//  Created by sergemi on 30/06/2025.
//

import SwiftUI

@MainActor
struct PreviewWrapper<Content: View>: View {
    // Здесь мы создаем источник истины для превью
    @State private var router: AppRouter
    @State private var errorManager: ErrorManager
    @State private var authService: AuthService
    @State private var dataManager: DataManager

    private var content: () -> Content

    // Добавляем инициализатор для гибкой настройки
    init(
        loginned: Bool = true,
        testDelayMax: Int = 0,
        withData: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) {
        // Важно: Инициализируем @State переменные именно так в init
        self._router = State(initialValue: AppRouter())
        self._errorManager = State(initialValue: ErrorManager())
        
        self._authService = State(initialValue: AuthService(service: MockAuthService.initWithMockUser(loginned: loginned)))
        self._dataManager = State(initialValue: MocDataManager(testDelayMax: testDelayMax, withData: withData))
        self.content = content
    }

    var body: some View {
        content()
            .environment(router)
            .environment(authService)
            .environment(dataManager)
            .environment(errorManager)
            .withErrorAlert(errorManager: errorManager)
    }
}
