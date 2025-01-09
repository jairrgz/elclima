//
//  CloudyView.swift
//  ElClima
//
//  Created by Jorge Jair Ramirez Gaston Zuloeta on 8/01/25.
//

import SwiftUI

struct CloudyView: View {
    let geometry: GeometryProxy
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(.black), Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            Image(systemName: "cloud.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                .animation(Animation.linear(duration: 5).repeatForever(autoreverses: false), value: geometry.size.width)
        }
    }
}

#Preview {
    GeometryReader(content: { geometry in
        CloudyView(geometry: geometry)
    })
    
}
