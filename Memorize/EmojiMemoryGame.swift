//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Alexander Kouthoofd on 6/12/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static let emojis = [ "✈️", "🚂", "🚁", "🚀", "🛴", "🚲", "🚒", "🚐", "🛻", "🚚", "🚛", "🚔", "🚍", "🚘", "🚖", "🚠", "🚆" ]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 10) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model = createMemoryGame()
        
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
        
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
