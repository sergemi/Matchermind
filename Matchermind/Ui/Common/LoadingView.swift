//
//  LoadingView.swift
//  Matchermind
//
//  Created by sergemi on 03.10.2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.white)
                .ignoresSafeArea()
            GeometryReader {geometry in
                let size = min(geometry.size.width, geometry.size.height) / 2
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(.circular)
                            .scaleEffect(size / 30)
                            .frame(width: size, height: size)
                        
                        Text("Loading...")
                            .font(.largeTitle)
                        
                        Spacer()
                        Spacer()
                    }
                    .onAppear() {
                        print(size)
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    LoadingView()
}
