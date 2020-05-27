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
    @Published private var model: MemoryGame<String>
    
    private(set) var theme: Theme
    
    init() {
        let game = EmojiMemoryGame.createMemoryGame()
        self.model = game.0
        self.theme = game.1
    }
   
    static func createMemoryGame() -> (MemoryGame<String>, Theme) {
        let theme = themes.randomElement()!
        let emojis = theme.setOfEmoji.shuffled()
        let numberOfPairsOfCards = theme.numberOfPairs ?? Int.random(in: 2...emojis.count)
        let model = MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCards) { emojis[$0] }
        return (model, theme)
    }
    
    // MARK: - Access to the Model
    
    var cards: [MemoryGame<String>.Card] { model.cards }
    var score: Int { model.score }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) { model.choose(card) }
    
    func restart() {
        // TODO: Repeat init() code, refactor it.
        let game = EmojiMemoryGame.createMemoryGame()
        self.model = game.0
        self.theme = game.1
    }
}
