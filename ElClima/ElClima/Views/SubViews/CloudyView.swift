//
//  CloudyView.swift
//  ElClima
//
//  Created by Jorge Jair Ramirez Gaston Zuloeta on 8/01/25.
//

import SwiftUI

struct CloudyView: View {
    let geometry: GeometryProxy
    @State private var isMoving = false
    @State private var opacity = 0.8
    @State private var scale = 1.0
    @State private var isRaining = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(.black), Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            // Efecto de lluvia
            ForEach(0..<15) { index in
                RainDrop(startPosition: randomPosition(in: geometry))
                    .opacity(isRaining ? 1 : 0)
            }
            
            // Sistema de nubes
            CloudSystem(isMoving: isMoving, opacity: opacity, scale: scale)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .onAppear {
            withAnimation(.spring().repeatForever(autoreverses: true)) {
                isMoving = true
                opacity = 1.0
                scale = 1.05
                isRaining = true
            }
        }
    }
    
    func randomPosition(in geometry: GeometryProxy) -> CGPoint {
        CGPoint(
            x: CGFloat.random(in: 0...geometry.size.width),
            y: CGFloat.random(in: 0...geometry.size.height/2)
        )
    }
}

struct CloudSystem: View {
    let isMoving: Bool
    let opacity: Double
    let scale: Double
    
    var body: some View {
        ZStack {
            // Nubes de fondo
            CloudLayer(size: 250, opacity: 0.3, offset: 50)
                .offset(x: isMoving ? 30 : -30)
            
            CloudLayer(size: 180, opacity: 0.2, offset: -30)
                .offset(x: isMoving ? -20 : 20)
            
            // Nube principal
            Image(systemName: "cloud.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.white.opacity(opacity))
                .scaleEffect(scale)
                .shadow(color: .white.opacity(0.2), radius: 10)
                .overlay(CloudVolume())
        }
    }
}

struct CloudLayer: View {
    let size: CGFloat
    let opacity: Double
    let offset: CGFloat
    
    var body: some View {
        Image(systemName: "cloud.fill")
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .foregroundColor(.white.opacity(opacity))
            .offset(y: offset)
            .blur(radius: 3)
    }
}

struct CloudVolume: View {
    var body: some View {
        Image(systemName: "cloud.fill")
            .resizable()
            .scaledToFit()
            .foregroundColor(.white.opacity(0.4))
            .blur(radius: 5)
            .offset(x: -5, y: -5)
    }
}

struct RainDrop: View {
    let startPosition: CGPoint
    @State private var endPosition: CGPoint
    @State private var opacity = 1.0
    
    init(startPosition: CGPoint) {
        self.startPosition = startPosition
        self._endPosition = State(initialValue: CGPoint(
            x: startPosition.x,
            y: startPosition.y + 400
        ))
    }
    
    var body: some View {
        Circle()
            .fill(Color.white)
            .frame(width: 2, height: 10)
            .opacity(opacity)
            .position(endPosition)
            .onAppear {
                withAnimation(
                    .linear(duration: Double.random(in: 0.8...1.2))
                    .repeatForever(autoreverses: false)
                ) {
                    endPosition = CGPoint(
                        x: startPosition.x,
                        y: startPosition.y + 400
                    )
                    opacity = 0.3
                }
            }
    }
}

#Preview {
    GeometryReader(content: { geometry in
        CloudyView(geometry: geometry)
    })
    
}
