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
    @Published private var model: MemoryGame<String>
    
    private(set) var theme = themes.randomElement()!
    
    init() {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
   
    private static func createMemoryGame(theme: Theme) -> (MemoryGame<String>) {
        let emojis = theme.setOfEmoji.shuffled()
        let numberOfPairsOfCards = theme.numberOfPairs ?? Int.random(in: 2...6)
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCards) { emojis[$0] }
    }
    
    private func randomTheme() {
        let oldTheme = theme
        var newTheme: Theme
        
        repeat {
            newTheme = themes.randomElement()!
        } while oldTheme.id == newTheme.id
        
        theme = newTheme
    }
    
    // MARK: - Access to the Model
    
    var cards: [MemoryGame<String>.Card] { model.cards }
    var score: Int { model.score }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) { model.choose(card) }
    
    func newGame() {
        randomTheme()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
}
