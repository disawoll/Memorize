//
//  MemoryGame.swift
//  Memorize
//  Model
//
//  Created by Doğan Mert Güven on 20.05.2020.
//  Copyright © 2020 Doğan Mert Güven. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    var cards: [Card]
    var score: Int
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        // $0 is the first argument, $1 is the second etc.
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                // newValue is a special var only appears inside set {}
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func matchScore() { score += 2 }
   
    mutating func mismatchScore() { score -= 1 }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    matchScore()
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        score = 0
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
            
            // Assaignment 1, Task 2
            cards.shuffle()
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        var id: Int
    }
}
