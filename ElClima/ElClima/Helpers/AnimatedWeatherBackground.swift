//
//  AnimatedWeatherBackground.swift
//  ElClima
//
//  Created by Jorge Jair Ramirez Gaston Zuloeta on 9/01/25.
//

import SwiftUI

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

