//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Alexander Kouthoofd on 6/12/22.
//

import SwiftUI

// ModelView
class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    typealias Theme = MemoryGame<String>.Theme
    
    private static let vehicleEmojis = [ "✈️", "🚂", "🚁", "🚀", "🛴", "🚲", "🚒", "🚐", "🛻", "🚚", "🚛", "🚔", "🚍", "🚘", "🚖", "🚠", "🚆" ]
    private static let smileyEmojis = [ "😀", "😃", "😄", "😆", "🥹", "😅" ]
    private static let flagEmojis = [ "🇺🇸", "🏳️‍🌈", "🇸🇦", "🇨🇳", "🏴‍☠️", "🇮🇶", "🏁", "🇻🇪" ]
    
    static let gameThemes: [Theme] = [
        .init(id: "Vehicle Game", allUsableContent: vehicleEmojis, numberOfPairs: 10, colorOfCards: .blue),
        .init(id: "Smiley Game", allUsableContent: smileyEmojis, numberOfPairs: 6, colorOfCards: .green),
        .init(id: "Flag Game", allUsableContent: flagEmojis, numberOfPairs: 8)
    ]
    
    static func createMemoryGame() -> MemoryGame<String> {
        let chosenTheme = gameThemes.randomElement()
        return MemoryGame<String>(with: chosenTheme!)
    }
    
    @Published private var model = createMemoryGame()
        
    var cards: Array<Card> {
        return model.cards
    }
    
    var currentTheme: Theme {
        return model.theme
    }
        
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
