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
    let game: EmojiMemoryGame
    
    @State private var timeFaceUp: Double = 1
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Group {
                    if card.isFaceUp {
                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: (1 - timeFaceUp) * 360 - 90))
                            .onAppear {
                                timeFaceUp = card.isMatched ? 0 : 1
                                withAnimation(.linear(duration: 2)) {
                                    timeFaceUp = 0
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                        // flip the card back over after the animation completes
                                        withAnimation {
                                            if (card.isFaceUp) {
                                                game.flip(card)
                                            }
                                        }
                                    }
                                }
                            }
                            
                    } else {
                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: 360 - 90))
                    }
                }
                .padding(DrawingConstants.timerCirclePadding)
                .opacity(DrawingConstants.timerCircleOpacity)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(.spring(), value: card.isMatched)
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
            
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let fontSize: CGFloat = 32
        static let timerCirclePadding: CGFloat = 5
        static let timerCircleOpacity: CGFloat = 0.5
    }
}
