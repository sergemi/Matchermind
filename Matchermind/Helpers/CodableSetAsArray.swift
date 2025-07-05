//
//  CodableSetAsArray.swift
//  Matchermind
//
//  Created by sergemi on 05/07/2025.
//

import Foundation

@propertyWrapper
struct CodableSetAsArray<T: Codable & Hashable>: Codable {
    var wrappedValue: Set<T>

    init(wrappedValue: Set<T>) {
        self.wrappedValue = wrappedValue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let array = try container.decode([T].self)
        self.wrappedValue = Set(array)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(Array(wrappedValue))
    }
}

extension CodableSetAsArray: Equatable where T: Equatable {}
extension CodableSetAsArray: Hashable where T: Hashable {}

