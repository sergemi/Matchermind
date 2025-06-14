//
//  ImageSourcePickerView.swift
//  Matchermind
//
//  Created by sergemi on 07/05/2025.
//

import SwiftUI

struct ImageSourcePickerView: View {
    let user: User
    var onFinish: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var authService: AuthService
    
    let storageService: StorageService = FirebaseStorageService()
    
    @State private var sourceType: ImagePickerView.SourceType?
    @State private var showPicker = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Сделать фото") {
                sourceType = .camera
                showPicker = true
            }
            
            Button("Выбрать из галереи") {
                sourceType = .photoLibrary
                showPicker = true
            }
            
            Button("Отмена", role: .cancel) {
                dismiss()
            }
        }
        .sheet(isPresented: $showPicker) {
            if let sourceType {
                ImagePickerView(sourceType: sourceType) { image in
                    uploadImage(image)
                }
            }
        }
    }
    
    private func uploadImage(_ image: UIImage) {
        Task {
            guard let uid = authService.user?.id else {
                print("Not authenticated")
                return
            }
            
            do {
                let url = try await storageService.uploadAvatar(image: image, userId: uid)
                try await authService.updateUserPhotoURL(url: url)
            } catch {
                print("Upload error: \(error)")
            }
            
            await MainActor.run {
                dismiss()
                onFinish()
            }
        }
    }
}
