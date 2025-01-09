//
//  ContentView.swift
//  ElClima
//
//  Created by Jorge Jair Ramirez Gaston Zuloeta on 8/01/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                if let location = locationManager.location {
                    Text("My latitud is \(location.latitude) and my longitud is \(location.longitude)")
                } else {
                    if locationManager.isLoading {
                        ProgressView()
                    } else {
                        FistView()
                            .environmentObject(locationManager)
                            .opacity(0.7)
                            .cornerRadius(25)
                            .edgesIgnoringSafeArea(.all)
                    }
                }
                
            }
            .padding()
            .background(Color(hue: 0.498, saturation: 1.0, brightness: 1.0))
            
        }
    }
}

#Preview {
    ContentView()
}
