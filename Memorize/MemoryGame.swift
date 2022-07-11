//
//  MemoryGame.swift
//  Memorize
//
//  Created by Alexander Kouthoofd on 6/12/22.
//

import Foundation
import SwiftUI

// Model
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var theme: Theme
    
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
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init(with theme: Theme) {
        self.theme = theme
        cards = []
        // add number numberOfPairs x 2 cards to cards array from theme
        var randomlySelectedContent = theme.allUsableContent
        randomlySelectedContent.shuffle()
        for pairIndex in 0..<theme.numberOfPairs {
            let content: CardContent = randomlySelectedContent[pairIndex]
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        
        let id: Int
    }
    
    struct Theme: Identifiable {
        let id: String
        let allUsableContent: [CardContent]
        let numberOfPairs: Int
        let colorOfCards: Color
        
        init(id: String, allUsableContent: [CardContent], numberOfPairs: Int) {
            self.init(id: id, allUsableContent: allUsableContent, numberOfPairs: numberOfPairs, colorOfCards: .red)
        }
        
        init(id: String, allUsableContent: [CardContent], numberOfPairs: Int, colorOfCards: Color) {
            self.id = id
            self.allUsableContent = allUsableContent
            self.numberOfPairs = allUsableContent.count < numberOfPairs ? allUsableContent.count : numberOfPairs
            self.colorOfCards = colorOfCards
        }
    }
}

extension Array {
    var oneAndOnly: Element? {
        return self.count == 1 ? self.first : nil
    }
}
