//
//  UserProfileImageView.swift
//  Matchermind
//
//  Created by sergemi on 07/05/2025.
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

struct UserProfileImageView: View {
    let user: User
    var size: CGFloat
    var editable: Bool = false
    var action: (() -> Void)? = nil
    
    @State private var imageURL: URL?
    @State private var showingImagePicker = false
    
    private func selectImage() {
        showingImagePicker = true
    }
    
    var body: some View {
        Button {
            if editable && action == nil {
                selectImage()
            } else {
                action?()
            }
        } label: {
            ZStack {
                Color.white
                // Placeholder до загрузки
                if imageURL == nil {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .foregroundColor(.gray)
                        .opacity(0.3)
                }

                // Загруженное изображение
                WebImage(url: imageURL)
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
            }
            .scaledToFill()
            .frame(width: size, height: size)
            .clipShape(Circle())
        }
        .buttonStyle(.plain)
        .frame(width: size, height: size)
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

