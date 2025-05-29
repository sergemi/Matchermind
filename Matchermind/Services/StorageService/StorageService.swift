//
//  StorageService.swift
//  Matchermind
//
//  Created by sergemi on 29/05/2025.
//

import Foundation

protocol StorageService {
    func fetchAvatarURL(userId: String) async throws -> URL
}
