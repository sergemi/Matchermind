//
//  ImageSourcePickerView.swift
//  Matchermind
//
//  Created by sergemi on 07/05/2025.
//

import SwiftUI
import FirebaseAuth

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
            guard let uid = Auth.auth().currentUser?.uid else {
                print("Not authenticated")
                return
            }
            
            do {
                let url = try await storageService.uploadAvatar(image: image, userId: uid)
                updateFirebaseUserPhotoURL(url: url)
            } catch {
                print("Upload error: \(error)")
            }
            
            await MainActor.run {
                dismiss()
                onFinish()
            }
        }
    }
    
    private func updateFirebaseUserPhotoURL(url: URL) {
        Auth.auth().currentUser?.createProfileChangeRequest().photoURL = url
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.commitChanges { error in
            if let error = error {
                print("Ошибка при обновлении профиля: \(error.localizedDescription)")
            } else {
                print("Профиль успешно обновлён")
                self.authService.notifyUserAvatarChanged()
            }
        }
    }
}
