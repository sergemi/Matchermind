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
    let mockService = MockAuthService.initWithMockUser(loginned: loginned)
    let mockWrapper = AuthService(service: mockService)

    content()
        .environmentObject(mocRouter)
        .environmentObject(mockWrapper)
}

@MainActor @ViewBuilder
func withMockDataEnvironment<Content: View>(
    loginned: Bool = true,
    @ViewBuilder content: @escaping () -> Content
) -> some View {
    let mocRouter = AppRouter()
    let mockService = MockAuthService.initWithMockUser(loginned: loginned)
    let mockWrapper = AuthService(service: mockService)
    let mocDataMgr: DataManager = MocDataManager()

    content()
        .environmentObject(mocRouter)
        .environmentObject(mockWrapper)
        .environmentObject(mocDataMgr)
}
