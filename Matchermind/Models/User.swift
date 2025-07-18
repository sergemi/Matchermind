//
//  User.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import Foundation

struct User: Equatable, Identifiable, Codable {
    let id: String
    let email: String
    var name: String? = nil //TODO: maybe change inicialization later
    var quickModuleId: String? = nil
    var quickTopicId: String? = nil
    var lastModuleId: String? = nil
    var lastTopicId: String? = nil
    var isCreator: Bool = true
}
