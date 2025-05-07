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
    var size: CGFloat
    @State private var imageURL: URL?
    @State private var showingImagePicker = false
    
    func selectImage() {
        showingImagePicker = true
    }

    var body: some View {
        VStack(spacing: 20) {
            if let imageURL {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: size, height: size)
                            .clipShape(Circle())
                    case .failure(_):
                        Image(systemName: "person.crop.circle.badge.exclamationmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: size, height: size)
                            .font(.largeTitle) // WTF?
                    default:
                        ProgressView()
                    }
                }
            } else {
//                Image(systemName: "person.crop.circle")
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
            }

            Button("Изменить фото") {
                selectImage()
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
