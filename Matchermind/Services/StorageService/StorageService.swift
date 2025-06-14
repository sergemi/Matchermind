//
//  StorageService.swift
//  Matchermind
//
//  Created by sergemi on 29/05/2025.
//

import SwiftUI

protocol StorageService {
    func fetchAvatarURL(userId: String) async throws -> URL
    func uploadAvatar(image: UIImage, userId: String) async throws -> URL
}

enum StorageServiceError: Error {
    case wrongData
    case noUser
    case uploadFailed
}
