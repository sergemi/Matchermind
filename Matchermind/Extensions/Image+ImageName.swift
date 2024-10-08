//
//  Image+ImageName.swift
//  Matchermind
//
//  Created by sergemi on 08.10.2024.
//

import SwiftUI

// Init image from bundle or from system in the same name

extension Image {
    enum ImageType: Hashable {
        case bundle(String)
        case system(String)
    }
    
    init(imageType: ImageType) {
        switch imageType {
        case .bundle(let imageName):
            self.init(imageName)
            
        case .system(let systemName):
            self.init(systemName: systemName)
        }
    }
}
