//
//  GameModeMenuView.swift
//  Ladder
//
//  Created by Mason Liebe on 12/23/25.
//

import SwiftUI

struct GameModeMenuView: View {
    let game: GameDefinition
    
    private let modes: [GameMode] = [.daily, .hardDaily, .unlimited]
    
    var body: some View {
        List(modes, id: \.self) { mode in
            NavigationLink(value: GameModeWrapper(game: game, mode: mode)) {
                Text(modeTitle(mode))
            }
        }
        .navigationTitle(game.name)
        .navigationDestination(for: GameModeWrapper.self) { wrapper in
            GameShellView(game: wrapper.game, mode: wrapper.mode)
        }
    }
    
    private func modeTitle(_ mode: GameMode) -> String {
        switch mode {
        case .daily:
            return "Daily"
        case .hardDaily:
            return "Hard Daily"
        case .unlimited:
            return "Unlimited"
        }
    }
}

struct GameModeWrapper: Hashable {
    let game: GameDefinition
    let mode: GameMode
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(game.id)
        hasher.combine(mode)
    }
    
    static func == (lhs: GameModeWrapper, rhs: GameModeWrapper) -> Bool {
        lhs.game.id == rhs.game.id && lhs.mode == rhs.mode
    }
}

