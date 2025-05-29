//
//  UserProfileImageView.swift
//  Matchermind
//
//  Created by sergemi on 07/05/2025.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import SDWebImageSwiftUI

struct UserProfileImageView: View {
    @EnvironmentObject var authService: AuthService // TODO: Remove?
    
//    let user: User
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
                // Placeholder
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .foregroundColor(.gray)
                        .opacity(0.3)

                // Avatar
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
            if let user = authService.user {
                ImageSourcePickerView(user: user) {
                    fetchImageURL(userId: user.id)
                            }
            }

//            ImageSourcePickerView(user: user) {
//                fetchImageURL()
//            }
        }
//        .onAppear {
//            if let user = authService.user {
//                fetchImageURL(userId: user.id)
//            }
//        }
        .task(id: authService.userAvatarVersion) {
            if let user = authService.user {
                fetchImageURL(userId: user.id)
            }
        }
    }
    
    private func fetchImageURL(userId: String) {
        let ref = Storage.storage().reference(withPath: "avatars/\(userId)/avatar.jpg")
        ref.downloadURL { url, _ in
            if let url = url {
                imageURL = url
            }
        }
        print("currentUser: \(Auth.auth().currentUser)")
        guard let url = Auth.auth().currentUser?.photoURL else {return}
        
        print(url)
        print("!!!")
    }
}

