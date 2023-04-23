//
//  GradientView.swift
//  Derootifier
//
//  Created by Анохин Юрий on 15.04.2023.
//

import SwiftUI

struct GradientView: View {
    let gradientColors = [Color(red: 0, green: 175/255, blue: 118/255), Color(red: 0, green: 238/255, blue: 181/255)]
    @State private var animateGradient = false
    
    var body: some View {
        LinearGradient(colors: gradientColors, startPoint: animateGradient ? .topLeading : .bottomLeading, endPoint: animateGradient ? .bottomTrailing : .topTrailing)
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.linear(duration: 10).repeatForever(autoreverses: true)) {
                    animateGradient.toggle()
                }
            }
    }
}

struct GradientView_Previews: PreviewProvider {
    static var previews: some View {
        GradientView()
    }
}
