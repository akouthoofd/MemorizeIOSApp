//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Alexander Kouthoofd on 6/12/22.
//

import SwiftUI

// ModelView
class EmojiMemoryGame: ObservableObject {
    static let vehicleEmojis = [ "✈️", "🚂", "🚁", "🚀", "🛴", "🚲", "🚒", "🚐", "🛻", "🚚", "🚛", "🚔", "🚍", "🚘", "🚖", "🚠", "🚆" ]
    static let smileyEmojis = [ "😀", "😃", "😄", "😆", "🥹", "😅" ]
    static let flagEmojis = [ "🇺🇸", "🏳️‍🌈", "🇸🇦", "🇨🇳", "🏴‍☠️", "🇮🇶", "🏁", "🇻🇪" ]
    
    static let gameThemes: [MemoryGame<String>.Theme] = [
        .init(id: "Vehicle Game", allUsableContent: vehicleEmojis, numberOfPairs: 10, colorOfCards: .blue),
        .init(id: "Smiley Game", allUsableContent: smileyEmojis, numberOfPairs: 6, colorOfCards: .green),
        .init(id: "Flag Game", allUsableContent: flagEmojis, numberOfPairs: 8),
    ]
    
    static func createMemoryGame() -> MemoryGame<String> {
        let chosenTheme = gameThemes.randomElement()
        return MemoryGame<String>(with: chosenTheme!)
    }
    
    @Published private var model = createMemoryGame()
        
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var currentTheme: MemoryGame<String>.Theme {
        return model.theme
    }
        
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
