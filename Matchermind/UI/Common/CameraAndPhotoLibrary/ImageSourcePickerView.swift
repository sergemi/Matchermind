//
//  ImageSourcePickerView.swift
//  Matchermind
//
//  Created by sergemi on 07/05/2025.
//

import SwiftUI
import FirebaseStorage
import FirebaseAuth

struct ImageSourcePickerView: View {
    let user: User
    var onFinish: () -> Void

    @Environment(\.dismiss) private var dismiss
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
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        
        guard let uid = Auth.auth().currentUser?.uid else {
            print("Not authenticated")
            return
        }

        let ref = Storage.storage().reference(withPath: "avatars/\(user.id)/avatar.jpg")
        print("ref: \(ref)")
        ref.putData(imageData, metadata: nil) { _, error in
            if error == nil {
                ref.downloadURL { url, _ in
                    if let url {
                        updateFirebaseUserPhotoURL(url: url)
                    }
                }
            }
            else {
                print("Error: \(String(describing: error))")
                print("")
            }

            DispatchQueue.main.async {
                dismiss()
                onFinish()
            }
        }
    }

    private func updateFirebaseUserPhotoURL(url: URL) {
        Auth.auth().currentUser?.createProfileChangeRequest().photoURL = url
        Auth.auth().currentUser?.createProfileChangeRequest().commitChanges(completion: nil)
    }
}
