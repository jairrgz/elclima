//
//  FirstView.swift
//  ElClima
//
//  Created by Jorge Jair Ramirez Gaston Zuloeta on 8/01/25.
//

import SwiftUI
import CoreLocationUI

struct FistView: View {
    @EnvironmentObject var locationManager: LocationManager
    @State private var weatherState: WeatherState = .cloudy
    
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
                VStack(spacing: 20) {
                    Text("""
                    Bienvenido a
                    El Clima
                    """)
                    .foregroundColor(weatherState == .stormy ? .white : (weatherState == .cloudy ? .blue: .white))
                    .bold()
                    .font(.largeTitle)
                    Spacer().frame(height: 300)
                    
                    Text("Por favor comparte, tu ubicación para obtener el clima en tu area")
                        .foregroundColor(weatherState == .stormy ? .white : .black)
                        .padding()
                }
                .multilineTextAlignment(.center)
                .padding()
                
                
                LocationButton(.shareCurrentLocation) {
                    locationManager.requestLocation()
                }
                
                .cornerRadius(30)
                .padding(.horizontal, 40)
                .symbolVariant(.fill)
                .foregroundColor(.white)
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 10).repeatForever(autoreverses: false)) {
                cycleWeather()
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
}

#Preview {
    FistView()
    
}

struct AnimatedWeatherBackground: View {
    @Binding var weatherState: FistView.WeatherState
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                switch weatherState {
                case .cloudy:
                    CloudyView(geometry: geometry)
                case .sunny:
                    SunnyView()
                case .stormy:
                    StormyView(geometry: geometry)
                }
            }
        }
    }
}


import SwiftUI

struct WeatherView: View {
    @State private var isAnimating = true
    
    var body: some View {
        ZStack {
            // Fondo con gradiente animado
            LinearGradient(
                colors: [Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Círculo animado con el sol/luna
                Circle()
                    .fill(Color.red)
                    .frame(width: 120, height: 120)
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.2), lineWidth: 2)
                            .scaleEffect(isAnimating ? 1.5 : 1.0)
                            .opacity(isAnimating ? 0 : 1)
                    )
                    .scaleEffect(isAnimating ? 1.1 : 1.0)
                
                // Temperatura
                Text("23°")
                    .font(.system(size: 96, weight: .thin))
                    .foregroundColor(.white)
                    .opacity(isAnimating ? 1 : 0)
                
                // Información del clima
                VStack(spacing: 10) {
                    Text("Soleado")
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Text("Madrid, España")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.8))
                }
                .offset(y: isAnimating ? 0 : 50)
                .opacity(isAnimating ? 1 : 0)
                
                // Detalles adicionales
                HStack(spacing: 40) {
                    WeatherDetailView(icon: "wind", value: "12 km/h")
                    WeatherDetailView(icon: "humidity", value: "64%")
                    WeatherDetailView(icon: "thermometer", value: "24°")
                }
                .offset(y: isAnimating ? 0 : 100)
                .opacity(isAnimating ? 1 : 0)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8)) {
                isAnimating = true
            }
        }
    }
}

struct WeatherDetailView: View {
    let icon: String
    let value: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
            Text(value)
                .foregroundColor(.white)
                .font(.subheadline)
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
