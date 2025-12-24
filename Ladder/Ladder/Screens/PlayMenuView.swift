//
//  PlayMenuView.swift
//  Ladder
//
//  Created by Mason Liebe on 12/23/25.
//

import SwiftUI

struct PlayMenuView: View {
    let games = GameRegistry.shared.allGames()
    
    var body: some View {
        List(games, id: \.id) { game in
            NavigationLink(value: game.wrapper) {
                GameIconView(game: game)
            }
        }
        .navigationTitle("Play")
        .navigationDestination(for: GameDefinitionWrapper.self) { wrapper in
            GameModeMenuView(game: wrapper.game)
        }
    }
}

struct GameDefinitionWrapper: Hashable {
    let game: GameDefinition
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(game.id)
    }
    
    static func == (lhs: GameDefinitionWrapper, rhs: GameDefinitionWrapper) -> Bool {
        lhs.game.id == rhs.game.id
    }
}

extension GameDefinition {
    var wrapper: GameDefinitionWrapper {
        GameDefinitionWrapper(game: self)
    }
}

