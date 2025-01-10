//
//  StormyView.swift
//  ElClima
//
//  Created by Jorge Jair Ramirez Gaston Zuloeta on 8/01/25.
//

import SwiftUI

struct StormyView: View {
    let geometry: GeometryProxy
    @State private var degrees = 0.0
    let rotationDuration: Double = 10 // Duración en segundos
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(.black), Color(.orange)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            Image(systemName: "cloud.bolt.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.yellow)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                .rotation3DEffect(
                    .degrees(degrees),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .onAppear {
                    withAnimation(
                        .linear(duration: rotationDuration)
                        .repeatForever(autoreverses: false)
                    ) {
                        degrees = 360
                    }
                }
        }
    }
}

#Preview {
    GeometryReader(content: { geometry in
        StormyView(geometry: geometry)
    })
}
