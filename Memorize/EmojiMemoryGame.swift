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
    
    private static let vehicleEmojis = [ "✈️", "🚂", "🚁", "🚀", "🛴", "🚲", "🚒", "🚐", "🛻", "🚚", "🚛", "🚔", "🚍", "🚘", "🚖", "🚠", "🚆" ]
    private static let smileyEmojis = [ "😀", "😃", "😄", "😆", "🥹", "😅" ]
    private static let flagEmojis = [ "🇺🇸", "🏳️‍🌈", "🇸🇦", "🇨🇳", "🏴‍☠️", "🇮🇶", "🏁", "🇻🇪" ]
    
    static let gameThemes: [Theme] = [
        .init(id: "Vehicle Game", allUsableContent: vehicleEmojis, numberOfPairs: 16, colorOfCards: .blue),
        .init(id: "Smiley Game", allUsableContent: smileyEmojis, numberOfPairs: 6, colorOfCards: .green),
        .init(id: "Flag Game", allUsableContent: flagEmojis, numberOfPairs: 8)
    ]
    
    @Published private var model: MemoryGame<String>
     
    private var selectedTheme: Theme
    
    init () {
        selectedTheme = EmojiMemoryGame.gameThemes.randomElement()!
        let theme = selectedTheme
        model = MemoryGame<String>(
            numberOfPairsOfCards: theme.numberOfPairs,
            createCardContent: { pairIndex in
                theme.allUsableContent[pairIndex]
            }
        )
    }
    
    var cards: Array<Card> { model.cards }
    var score: Int { model.score}
    var theme: Theme { selectedTheme }
    
    struct Theme: Identifiable {
        let id: String
        let allUsableContent: [String]
        let numberOfPairs: Int
        let colorOfCards: Color
        
        init(id: String, allUsableContent: [String], numberOfPairs: Int) {
            self.init(id: id, allUsableContent: allUsableContent, numberOfPairs: numberOfPairs, colorOfCards: .red)
        }
        
        init(id: String, allUsableContent: [String], numberOfPairs: Int, colorOfCards: Color) {
            self.id = id
            self.allUsableContent = allUsableContent
            self.numberOfPairs = allUsableContent.count < numberOfPairs ? allUsableContent.count : numberOfPairs
            self.colorOfCards = colorOfCards
        }
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        startNewGame(with: EmojiMemoryGame.gameThemes.randomElement()!)
    }
    
    func startNewGame(with theme: Theme) {
        selectedTheme = theme
        model = MemoryGame<String>(
            numberOfPairsOfCards: selectedTheme.numberOfPairs,
            createCardContent: { pairIndex in
                selectedTheme.allUsableContent[pairIndex]
            }
        )
    }
}
