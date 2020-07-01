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
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card).onTapGesture {
                            withAnimation(.linear(duration: flipDuration)) {
                                viewModel.choose(card: card)
                            }
                        }
                        .scaledToFill()
                        .padding(.vertical)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                Text("Score: \(viewModel.score)")
                    .font(.largeTitle)
                    .padding(.bottom)
            }
            .accentColor(viewModel.theme.accentColor)
            .foregroundColor(viewModel.theme.accentColor)
            .navigationBarTitle(viewModel.theme.name)
            .navigationBarItems(trailing:
                Button("New Game") {
                    withAnimation(.easeInOut(duration: shuffleDuration)) {
                        viewModel.newGame()
                    }
                }
            )
        }
    }
    
    // MARK: - Drawing Constants
    
    private let flipDuration: Double = 0.75
    private let shuffleDuration: Double = 1
    private let gridPadding: CGFloat = 5
    private let gridSpacing: CGFloat = 35
    // TODO: - Column count must be adjustable. 4 is placeholder.
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)

}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { body(for: $0.size) }
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
                        .onAppear { startBonusTimeAnimation() }
                    } else {
                        Pie(
                            startAngle: Angle.degrees(startAngle),
                            endAngle: Angle.degrees(-animatedBonusRemaining*360-90),
                            clockwise: true
                        )
                    }
                }
                .aspectRatio(2/3, contentMode: .fill)
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
