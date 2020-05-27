//
//  EmojiMemoryGame.swift
//  Memorize
//  ViewModel
//
//  Created by Doğan Mert Güven on 20.05.2020.
//  Copyright © 2020 Doğan Mert Güven. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    // private(set) only class can modify the variable but other things can see it too.
    // private only class can read & write
    // <Content> is a String in this case.
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private(set) var theme: Theme = themes.randomElement()!
   
    static func createMemoryGame() -> MemoryGame<String> {
        let theme = themes.randomElement()!
        let emojis = theme.setOfEmoji.shuffled()
        let numberOfPairsOfCards = theme.numberOfPairs ?? Int.random(in: 2...emojis.count)
        
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCards) { emojis[$0] }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> { model.cards }
    // var score
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) { model.choose(card) }
    func restart() { model = EmojiMemoryGame.createMemoryGame() }
    func report() { print("\(theme.name)") }
}
