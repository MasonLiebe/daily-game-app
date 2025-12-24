//
//  GameIconView.swift
//  Ladder
//
//  Created by Mason Liebe on 12/23/25.
//

import SwiftUI

struct GameIconView: View {
    let game: GameDefinition
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: game.iconName)
                .font(.title2)
                .foregroundColor(.accentColor)
                .frame(width: 32, height: 32)
            
            Text(game.name)
                .font(.body)
        }
        .padding(.vertical, 4)
    }
}

