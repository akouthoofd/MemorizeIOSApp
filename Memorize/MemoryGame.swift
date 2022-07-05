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
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
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
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    init(with theme: Theme) {
        self.theme = theme
        cards = Array<Card>()
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
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        
        var id: Int
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
