//
//  User.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import Foundation

struct User: Equatable, Identifiable {
    let id: String
    let email: String
    var name: String? = nil //TODO: maybe change inicialization later
    var quickModuleId: String? = nil
    var lastModuleId: String? = nil
    var lastTopicId: String? = nil
    var isEditor: Bool = true
}
