//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Alexander Kouthoofd on 5/15/22.
//

import SwiftUI

// View
struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text(game.currentTheme.id)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Spacer()
                    Button {
                        game.startNewGame()
                    } label: {
                       Image(systemName: "arrow.triangle.2.circlepath")
                    }
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(game.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }
                .foregroundColor(game.currentTheme.colorOfCards)
            }
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
         EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
    }
}
