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
    // TODO: - Implement time based scoring
    
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
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        var content: CardContent
        var id: Int
        
        // MARK: - Bonus Time
        
        // this could give matching bonus points
        // if the user matches the card
        // before a certain amount of time passes during which the card is face up

        // can be zero which means "no bonus points" for this card
        var bonusTimeLimit: TimeInterval = 6

        // how long this card has ever face up
        private var faceUptime: TimeInterval {
            if let lastFaceUpDate = lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }

        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        // the accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0

        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - pastFaceUpTime)
        }

        // percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }

        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }

        // whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }

        // called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }

        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUptime
            lastFaceUpDate = nil
        }
    }
}
