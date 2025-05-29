//
//  FirebaseStorageService.swift
//  Matchermind
//
//  Created by sergemi on 29/05/2025.
//

import Foundation

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
    
    
}
