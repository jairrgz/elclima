//
//  SunnyView.swift
//  ElClima
//
//  Created by Jorge Jair Ramirez Gaston Zuloeta on 8/01/25.
//

import SwiftUI

struct SunnyView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.blue, .white, .yellow],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            Image(systemName: "sun.max.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.yellow)
        }
    }
}

#Preview {
    GeometryReader(content: { geometry in
        SunnyView()
    })
    
}
