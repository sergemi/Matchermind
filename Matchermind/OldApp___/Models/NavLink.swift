//
//  NavLink.swift
//  Matchermind
//
//  Created by sergemi on 03.10.2024.
//

import Foundation

enum NavLink: Hashable, Identifiable {
    case authLogin
    case authRegister
    
    case mainLearnView
    case resumeLearnView
    case startNewLearnView
    
    case profileView
    
    var id: String {
        String(describing: self)
    }
}
