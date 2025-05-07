//
//  UserProfileImageView.swift
//  Matchermind
//
//  Created by sergemi on 07/05/2025.
//

import SwiftUI
import FirebaseStorage

struct UserProfileImageView: View {
    let user: User
    @State private var imageURL: URL?
    @State private var showingImagePicker = false

    var body: some View {
        VStack(spacing: 20) {
            if let imageURL {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    case .failure(_):
                        Image(systemName: "person.crop.circle.badge.exclamationmark")
                            .font(.largeTitle)
                    default:
                        ProgressView()
                    }
                }
            } else {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            }

            Button("Изменить фото") {
                showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImageSourcePickerView(user: user) {
                fetchImageURL()
            }
        }
        .onAppear {
            fetchImageURL()
        }
    }

    private func fetchImageURL() {
        let ref = Storage.storage().reference(withPath: "avatars/\(user.id)/avatar.jpg")
        ref.downloadURL { url, _ in
            if let url = url {
                imageURL = url
            }
        }
    }
}
