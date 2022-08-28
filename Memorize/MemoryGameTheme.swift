//
//  MemoryGameTheme.swift
//  Memorize
//
//  Created by Alexander Kouthoofd on 8/9/22.
//

import Foundation
import SwiftUI

struct MemoryGameTheme<ContentType>: Identifiable{
    let id: String
    let allUsableContent: [ContentType]
    let numberOfPairs: Int
    let colorOfCards: Color
    
    init(id: String, allUsableContent: [ContentType], numberOfPairs: Int) {
        self.init(id: id, allUsableContent: allUsableContent, numberOfPairs: numberOfPairs, colorOfCards: .red)
    }
    
    init(id: String, allUsableContent: [ContentType], numberOfPairs: Int, colorOfCards: Color) {
        self.id = id
        self.allUsableContent = allUsableContent
        self.numberOfPairs = allUsableContent.count < numberOfPairs ? allUsableContent.count : numberOfPairs
        self.colorOfCards = colorOfCards
    }
}
