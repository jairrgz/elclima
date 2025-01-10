//
//  FirstView.swift
//  ElClima
//
//  Created by Jorge Jair Ramirez Gaston Zuloeta on 8/01/25.
//

import SwiftUI

struct FistView: View {
    @EnvironmentObject var locationManager: LocationManager
    @State private var weatherState: WeatherState = .cloudy
    @State private var showButton = false  // Para controlar la visibilidad del botón
    @State private var buttonOffset: CGFloat = 0  // Para la animación de salto
    
    enum WeatherState {
        case cloudy, sunny, stormy
    }
    
    var body: some View {
        ZStack {
            Color.gray
                .edgesIgnoringSafeArea(.all)
            AnimatedWeatherBackground(weatherState: $weatherState)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack(spacing: 10) {
                    Text("""
                    Bienvenido a
                    El Clima
                    """)
                    .foregroundColor(weatherState == .stormy ? .white : (weatherState == .cloudy ? .blue: .white))
                    .bold()
                    .font(.largeTitle)
                    
                    Spacer()
                    
                    Text("Planeas viajar y no sabes que llevar")
                        .font(.largeTitle)
                        .foregroundColor(weatherState == .stormy ? .white : .black)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 30))
                        .foregroundColor(weatherState == .stormy ? .black : (weatherState == .cloudy ? .blue : .white))
                    
                    HStack(spacing: 25) {
                        Image("question")
                            .resizable()
                            .frame(width: 170, height: 100)
                        
                        // Botón modificado con animación
                        if showButton {
                            Button(action: {
                                // Acción del botón
                            }) {
                                Text("""
                                    Haz click
                                    Aqui para ver el clima de la ciudad
                                    """)
                                .foregroundColor(weatherState == .stormy ? .white : .black)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.white.opacity(0.2))
                                )
                            }
                            .offset(y: buttonOffset)
                            .animation(
                                Animation
                                    .interpolatingSpring(mass: 1, stiffness: 100, damping: 10, initialVelocity: 0)
                                    .repeatForever(autoreverses: true),
                                value: buttonOffset
                            )
                            .transition(.scale.combined(with: .opacity))
                        }
                    }
                }
                .multilineTextAlignment(.center)
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
            // Timer para el ciclo del clima
            withAnimation(Animation.linear(duration: 10).repeatForever(autoreverses: false)) {
                cycleWeather()
            }
            
            // Timer para mostrar el botón después de 5 segundos
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation(.spring()) {
                    showButton = true
                }
                startJumpingAnimation()
            }
        }
    }
    
    private func cycleWeather() {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            switch weatherState {
            case .cloudy:
                weatherState = .sunny
            case .sunny:
                weatherState = .stormy
            case .stormy:
                weatherState = .cloudy
            }
        }
    }
    
    private func startJumpingAnimation() {
        // Animación de salto
        withAnimation(
            Animation
                .easeInOut(duration: 1)
                .repeatForever(autoreverses: true)
        ) {
            buttonOffset = 0
        }
    }
}

#Preview {
    FistView()
    
}

