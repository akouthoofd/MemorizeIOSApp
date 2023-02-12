//
//  MemoryGame.swift
//  Memorize
//
//  Created by Alexander Kouthoofd on 6/12/22.
//

import Foundation

// Model
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    score = max(
                        cards.indices
                            .filter({ $0 == chosenIndex || $0 == potentialMatchIndex })
                            .reduce(score, { (partialResult, index) in cards[index].isPreviouslySeen ? partialResult - 1 : partialResult }),
                        0
                    )
                }
                
                cards[chosenIndex].isFaceUp = true
                cards[chosenIndex].isPreviouslySeen = true
                cards[potentialMatchIndex].isPreviouslySeen = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        // add number numberOfPairsOfCards x 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false //{
//            didSet {
//                if isFaceUp {
//                    startUsingBonusTime()
//                } else {
//                    stopUsingBonusTime()
//                }
//            }
//        }
        var isMatched = false //{
//            didSet {
//                stopUsingBonusTime()
//            }
//        }
        var isPreviouslySeen = false
        let content: CardContent
        
        let id: Int
        
//        var bonusTimeRemaining: TimeInterval {
//            max(0, bonu)
//        }
//
//        var isConsumingBonusTime: Bool {
//            isFaceUp && !isMatched && bon
//        }
//
//        private mutating func startUsingBonusTime() {
//            if isConsumingBonusTime, lastFaceUpDate == nil {
//                lastFaceUpDate = Date()
//            }
//        }
//
//        private mutating func stopUsingBonusTime() {
//            pastFaceUpTime = faceUpTime
//            self.lastFaceUpDate = nil
//        }
    }
}

extension Array {
    var oneAndOnly: Element? {
        return self.count == 1 ? self.first : nil
    }
}
