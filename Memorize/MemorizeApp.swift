//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Alexander Kouthoofd on 5/15/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
