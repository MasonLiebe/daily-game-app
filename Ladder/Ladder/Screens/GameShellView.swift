//
//  GameShellView.swift
//  Ladder
//
//  Created by Mason Liebe on 12/23/25.
//

import SwiftUI

struct GameShellView: View {
    let game: GameDefinition
    let mode: GameMode
    
    @State private var startTime = Date()
    
    var body: some View {
        VStack(spacing: 0) {
            GameHeaderView(gameName: game.name)
            
            game.makeView(mode: mode)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if game.supportsKeyboard(mode: mode) {
                KeyboardContainer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            startTime = Date()
        }
    }
}

