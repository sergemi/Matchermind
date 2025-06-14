//
//  FirebaseStorageService.swift
//  Matchermind
//
//  Created by sergemi on 29/05/2025.
//

import SwiftUI

import FirebaseStorage

class FirebaseStorageService: StorageService {
    func fetchAvatarURL(userId: String) async throws -> URL {
        let ref = Storage.storage().reference(withPath: "avatars/\(userId)/avatar.jpg")
        
        return try await withCheckedThrowingContinuation { continuation in
            ref.downloadURL { url, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let url = url {
                    continuation.resume(returning: url)
                } else {
                    continuation.resume(throwing: URLError(.badURL))
                }
            }
        }
    }
    
    func uploadAvatar(image: UIImage, userId: String) async throws -> URL {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw StorageServiceError.wrongData
        }
        
        let ref = Storage.storage().reference(withPath: "avatars/\(userId)/avatar.jpg")
        
        let _ = try await putData(ref: ref, data: imageData)
        
        let url = try await ref.downloadURL()
        
        return url
    }
    
    private func putData(ref: StorageReference, data: Data) async throws -> StorageMetadata {
        try await withCheckedThrowingContinuation { continuation in
            ref.putData(data, metadata: nil) { metadata, error in
                if let error = error {
                    continuation.resume(throwing: error)
                }
                else if let metadata = metadata {
                    continuation.resume(returning: metadata)
                }
                else {
                    continuation.resume(throwing: StorageServiceError.uploadFailed)
                }
            }
        }
    }
}
