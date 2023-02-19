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
    typealias Theme = MemoryGameTheme<String>
    
    private static let vehicleEmojis = [ "✈️", "🚂", "🚁", "🚀", "🛴", "🚲", "🚒", "🚐", "🛻", "🚚", "🚛", "🚔", "🚍", "🚘", "🚖", "🚠", "🚆" ]
    private static let smileyEmojis = [ "😀", "😃", "😄", "😆", "🥹", "😅" ]
    private static let flagEmojis = [ "🇺🇸", "🏳️‍🌈", "🇸🇦", "🇨🇳", "🏴‍☠️", "🇮🇶", "🏁", "🇻🇪" ]
    
    static let gameThemes: [Theme] = [
        .init(id: "Vehicle Game", allUsableContent: vehicleEmojis, numberOfPairs: 16, colorOfCards: .blue),
        .init(id: "Smiley Game", allUsableContent: smileyEmojis, numberOfPairs: 6, colorOfCards: .green),
        .init(id: "Flag Game", allUsableContent: flagEmojis, numberOfPairs: 8)
    ]
    
    @Published private var gameLogic: MemoryGame<String>
    @Published private var selectedTheme: Theme
    
    init () {
        let theme = EmojiMemoryGame.gameThemes.randomElement()!
        selectedTheme = theme
        gameLogic = MemoryGame<String>(
            numberOfPairsOfCards: theme.numberOfPairs,
            createCardContent: { pairIndex in
                theme.allUsableContent[pairIndex]
            }
        )
    }
    
    var cards: Array<Card> { gameLogic.cards }
    var score: Int { gameLogic.score}
    var theme: Theme { selectedTheme }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        gameLogic.choose(card)
    }
    
    func flip(_ card: Card) {
        gameLogic.flipUnmatchedCard(card)
    }
    
    func startNewGame() {
        startNewGame(with: EmojiMemoryGame.gameThemes.randomElement()!)
    }
    
    func startNewGame(with theme: Theme) {
        selectedTheme = theme
        gameLogic = MemoryGame<String>(
            numberOfPairsOfCards: selectedTheme.numberOfPairs,
            createCardContent: { pairIndex in
                selectedTheme.allUsableContent[pairIndex]
            }
        )
    }
}
