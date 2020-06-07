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
                        withAnimation(.linear(duration: self.flipDuration)) {
                            self.viewModel.choose(card: card)
                        }
                    }
                    .padding(self.gridPadding)
                }
                .padding(.horizontal)
                
                Text("Score: \(viewModel.score)")
                    .font(.largeTitle)
                    .padding(.bottom)
            }
            .accentColor(viewModel.theme.accentColor)
            .foregroundColor(viewModel.theme.accentColor)
            .navigationBarTitle(viewModel.theme.name)
            .navigationBarItems(trailing:
                Button("New Game") {
                    withAnimation(.easeInOut(duration: self.shuffleDuration)) {
                        self.viewModel.newGame()
                    }
                }
            )
        }
    }
    
    // MARK: - Drawing Constants
    
    private let flipDuration: Double = 0.75
    private let shuffleDuration: Double = 1
    private let gridPadding: CGFloat = 5
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { self.body(for: $0.size) }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            Group {
                ZStack {
                    if card.isConsumingBonusTime {
                        Pie(
                            startAngle: Angle.degrees(startAngle),
                            endAngle: Angle.degrees(-animatedBonusRemaining*360-90),
                            clockwise: true
                        )
                        .onAppear { self.startBonusTimeAnimation() }
                    } else {
                        Pie(
                            startAngle: Angle.degrees(startAngle),
                            endAngle: Angle.degrees(-animatedBonusRemaining*360-90),
                            clockwise: true
                        )
                    }
            }
            .padding(padding)
            .opacity(opacity)
            Text(card.content)
                .font(Font.system(size: fontSize(for: size)))
                .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                .animation(card.isMatched ? Animation.linear(duration: spinningDuration).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
        }
    }
    
        // MARK: - Drawing Constants
        
    private func fontSize(for size: CGSize) -> CGFloat { min(size.width, size.height) * 0.7 }
    private let padding: CGFloat = 10
    private let opacity: Double = 0.4
    private let startAngle: Double = 0-90
    //private let endAngle: Double = -animatedBonusRemaining*360-90
    private let spinningDuration: Double = 1
}

    // MARK: - SwiftUI Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[2])
        return EmojiMemoryGameView(viewModel: game)
    }
}
