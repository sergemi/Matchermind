//
//  UserProfileImageView.swift
//  Matchermind
//
//  Created by sergemi on 07/05/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserProfileImageView: View {
    @EnvironmentObject var authService: AuthService // TODO: Remove?
    
    let storageService: StorageService = FirebaseStorageService()
    
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
                        Task {
                            do {
                                let url = try await storageService.fetchAvatarURL(userId: user.id)
                                imageURL = url
                            } catch {
                                print("Failed to fetch image URL after image picker:", error)
                            }
                        }
                    }
                }
        }
        .task(id: authService.userAvatarVersion) {
            if let user = authService.user {
                    do {
                        let url = try await storageService.fetchAvatarURL(userId: user.id)
                        imageURL = url
                    } catch {
                        print("Failed to fetch image URL:", error)
                    }
                }
        }
    }
}

