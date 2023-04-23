//
//  TintedButton.swift
//  Derootifier
//
//  Created by Анохин Юрий on 15.04.2023.
//

import SwiftUI

struct TintedButton: ButtonStyle {
    var color: Color
    var material: UIBlurEffect.Style?
    var fullwidth: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            if fullwidth {
                configuration.label
                    .padding(15)
                    .frame(maxWidth: .infinity)
                    .background(material == nil ? AnyView(color.opacity(0.2)) : AnyView(MaterialView(material!)))
                    .cornerRadius(8)
                    .foregroundColor(color)
            } else {
                configuration.label
                    .padding(15)
                    .background(material == nil ? AnyView(color.opacity(0.2)) : AnyView(MaterialView(material!)))
                    .cornerRadius(8)
                    .foregroundColor(color)
            }
        }
    }
    
    init(color: Color = .blue, fullwidth: Bool = false) {
        self.color = color
        self.fullwidth = fullwidth
    }
    init(color: Color = .blue, material: UIBlurEffect.Style, fullwidth: Bool = false) {
        self.color = color
        self.material = material
        self.fullwidth = fullwidth
    }
}
