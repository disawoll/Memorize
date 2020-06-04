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
    private(set) var cards: [Card]
    var openedCards = [Card]()
    var score = 0
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        // $0 is the first argument, $1 is the second etc.
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            // turns all other cards face down
            for index in cards.indices {
                if cards[index].isFaceUp { openedCards.append(cards[index]) }
                // newValue is a special var only appears inside set {}
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func adjustScore(isMatched: Bool) { isMatched ? (score += 2) : (score -= 1) }
    
    mutating func choose(_ card: Card) {
        // if let syntax is called optional binding.
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isMatched {
            // only choose cards that are unmatched
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard, potentialMatchIndex != chosenIndex {
                // can't choose the same card twice
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    // here is a match case
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    adjustScore(isMatched: true)
                } else {
                    // here is a mismatch case
                    if (openedCards.firstIndex(matching: cards[chosenIndex]) != nil) { adjustScore(isMatched: false) }
                    if (openedCards.firstIndex(matching: cards[potentialMatchIndex]) != nil) { adjustScore(isMatched: false) }
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                // if there are zero or more than one face up cards
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
            
            // Assignment 1, Task 2
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
