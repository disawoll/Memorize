//
//  EmojiMemoryGame.swift
//  Memorize
//  ViewModel
//
//  Created by Doğan Mert Güven on 20.05.2020.
//  Copyright © 2020 Doğan Mert Güven. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame {
    
    // private(set) only class can modify the variable but other things can see it too.
    // private only class can read & write
    // <Content> is a String in this case.
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
   
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["🇬🇧","🇺🇸","🇹🇷","🇨🇦","🇯🇵","🇩🇪",
                      "🇳🇴","🇨🇿","🇦🇹","🇭🇺","🇳🇱","🇫🇷",
                      "🇵🇱","🇧🇷","🇮🇪","🇳🇴","🇧🇪","🇷🇺"]
        
        // Assaignment 1, Task 4, Extra Credit 1
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2...5)) {
            pairIndex in emojis.shuffled()[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> { model.cards }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) { model.choose(card: card) }
}
