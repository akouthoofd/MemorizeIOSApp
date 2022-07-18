//
//  CardView.swift
//  Memorize
//
//  Created by Alexander Kouthoofd on 7/10/22.
//

import Foundation
import SwiftUI

struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            let displayedCard = ZStack {
                Text(card.content)
                    .font(font(in: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
            if (card.isMatched)  {
                displayedCard.opacity(0)
            } else {
                displayedCard
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.5
    }
}
