//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Alexander Kouthoofd on 6/12/22.
//

import SwiftUI

class EmojiMemoryGame {
    static let emojis = [ "✈️", "🚂", "🚁", "🚀", "🛴", "🚲", "🚒", "🚐", "🛻", "🚚", "🚛", "🚔", "🚍", "🚘", "🚖", "🚠" ]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    private var model = createMemoryGame()
        
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
}
