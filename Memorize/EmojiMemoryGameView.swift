//
//  EmojiMemoryGameView.swift
//  Memorize
//  View
//
//  Created by Doğan Mert Güven on 20.05.2020.
//  Copyright © 2020 Doğan Mert Güven. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        Grid(viewModel.cards) { card in
            CardView(card: card).onTapGesture {
                self.viewModel.choose(card: card)
            }
            .padding(5)
        }
        .foregroundColor(Color.orange)
        .padding()
//        // Assaignment 1, Task 5 :: ternary operator
//        .font(viewModel.cards.count/2 < 5 ? Font.largeTitle : Font.system(size: 16))
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { self.body(for: $0.size) }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }
//        // Assaignment 1, Task 3
//        .aspectRatio(2/3, contentMode: .fit)
            .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    
    let cornerRadius: CGFloat = 10
    let edgeLineWidth: CGFloat = 3
    func fontSize(for size: CGSize) -> CGFloat {
        // "min(CGFloat, CGFloat) -> CGFloat" is a method of CGFloat, returns the lesser of the two values.
        min(size.width, size.height) * 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
