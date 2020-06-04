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
        NavigationView {
            VStack {
                Grid(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        self.viewModel.choose(card: card)
                    }
                    .padding(5)
                }
                .padding(.horizontal)
                
                Text("Score: \(viewModel.score)")
                    .font(.largeTitle)
                    .padding(.bottom)
            }
            .accentColor(viewModel.theme.accentColor)
            .foregroundColor(viewModel.theme.accentColor)
            // Assignment 2 Task 7
            .navigationBarTitle(viewModel.theme.name)
            // Assignment 2 Task 6
            .navigationBarItems(trailing: Button("New Game", action: viewModel.newGame))
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { self.body(for: $0.size) }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(
                    startAngle: Angle.degrees(0-90),
                    endAngle: Angle.degrees(110-90),
                    clockwise: true
                )
                .padding(10).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    // MARK: - Drawing Constants
    
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
    private func fontSize(for size: CGSize) -> CGFloat {
        // "min(CGFloat, CGFloat) -> CGFloat" is a method of CGFloat, returns the lesser of the two values.
        min(size.width, size.height) * 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[2])
        return EmojiMemoryGameView(viewModel: game)
    }
}
