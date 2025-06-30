//
//  PreviewHelpers.swift
//  MyRouter
//
//  Created by sergemi on 05/05/2025.
//

import Foundation

import SwiftUI

@MainActor @ViewBuilder
func withMockEnvironment<Content: View>(
    loginned: Bool = true,
    @ViewBuilder content: @escaping () -> Content
) -> some View {
    let mocRouter = AppRouter()
    let errorMgr = ErrorManager()
    let mockService = MockAuthService.initWithMockUser(loginned: loginned)
    let mockWrapper = AuthService(service: mockService)

    content()
        .environment(mocRouter)
        .environment(mockWrapper)
        .environment(errorMgr)
        .withErrorAlert(errorManager: errorMgr)
}

@MainActor @ViewBuilder
func withMockDataEnvironment<Content: View>(
    loginned: Bool = true,
    testDelayMax: Int = 0,
    withData: Bool = true,
    @ViewBuilder content: @escaping () -> Content
) -> some View {
    let mocRouter = AppRouter()
    let errorMgr = ErrorManager()
    let mockService = MockAuthService.initWithMockUser(loginned: loginned)
    let mockWrapper = AuthService(service: mockService)
    let mocDataMgr: DataManager = MocDataManager(testDelayMax: testDelayMax, withData: withData)

    content()
        .environment(mocRouter)
        .environment(mockWrapper)
        .environment(mocDataMgr)
        .environment(errorMgr)
        .withErrorAlert(errorManager: errorMgr)
}
