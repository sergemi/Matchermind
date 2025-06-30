//
//  DataManagerError.swift
//  Matchermind
//
//  Created by sergemi on 30/06/2025.
//

import Foundation

enum DataManagerError: Error, LocalizedError {
    case unknownError
    case userNotFound
    case moduleNotFound
    case topicNotFound
    case learnedWordNotFound
    case wordPairNotFound
    case updateDataError
}
