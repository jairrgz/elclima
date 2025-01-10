//
//  SunnyView.swift
//  ElClima
//
//  Created by Jorge Jair Ramirez Gaston Zuloeta on 8/01/25.
//

import SwiftUI

struct SunnyView: View {
    @State private var isGlowing = false
    @State private var size = 1.0
    @State private var rotation = 0.0
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.blue, .white, .yellow],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            // Capa de resplandor exterior
            Circle()
                .fill(RadialGradient(
                    gradient: Gradient(colors: [.yellow.opacity(0.3), .clear]),
                    center: .center,
                    startRadius: 50,
                    endRadius: 150
                ))
                .frame(width: 300, height: 300)
                .scaleEffect(isGlowing ? 1.2 : 0.8)
                .animation(
                    .easeInOut(duration: 2)
                    .repeatForever(autoreverses: true),
                    value: isGlowing
                )
            
            // Capa de resplandor medio
            Image(systemName: "sun.max.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 220, height: 220)
                .foregroundColor(.yellow.opacity(0.3))
                .blur(radius: 20)
                .rotationEffect(.degrees(rotation))
                .animation(
                    .linear(duration: 10)
                    .repeatForever(autoreverses: false),
                    value: rotation
                )
            
            // Sol principal
            Image(systemName: "sun.max.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.yellow)
                .scaleEffect(size)
                .shadow(color: .yellow, radius: 20, x: 0, y: 0)
                .animation(
                    .easeInOut(duration: 1.5)
                    .repeatForever(autoreverses: true),
                    value: size
                )
                .overlay(
                    Circle()
                        .stroke(Color.yellow.opacity(0.5), lineWidth: 2)
                        .scaleEffect(isGlowing ? 1.1 : 0.9)
                        .animation(
                            .easeOut(duration: 1)
                            .repeatForever(autoreverses: true),
                            value: isGlowing
                        )
                )
        }
        .onAppear {
            isGlowing = true
            size = 1.05
            rotation = 360
        }
    }
}

#Preview {
    GeometryReader(content: { geometry in
        SunnyView()
    })
    
}
