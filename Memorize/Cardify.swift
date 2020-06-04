//
//  Cardify.swift
//  Memorize
//
//  Created by Doğan Mert Güven on 5.06.2020.
//  Copyright © 2020 Doğan Mert Güven. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill(
                    // Assignment 2 Extra Credit 1
                    AngularGradient(
                        gradient: Gradient(colors: [Color.white, Color.accentColor, Color.black]),
                        center: .bottomLeading,
                        startAngle: .degrees(180),
                        endAngle: .degrees(400)
                    )
                )
            }
        }
    }
    
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
