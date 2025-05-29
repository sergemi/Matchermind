//
//  ProfileButton.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//
// TODO: remove ?
import SwiftUI

struct ProfileButton: View {
    var image: Image? = nil
    var size: CGFloat
    
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            ZStack {
                if let image = image {
                    image
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                }
            }
            .background(Color.white)
            .frame(width: size, height: size)
            .clipShape(Circle())
            
            .overlay(
                Circle()
                    .stroke(Color.secondary, lineWidth: 1)
//                    .stroke(Color.red, lineWidth: 1)
            )
             
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ProfileButton(size: 44){}
}
