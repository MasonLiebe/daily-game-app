//
//  GameRegistry.swift
//  Ladder
//
//  Created by Mason Liebe on 12/23/25.
//

import Foundation

class GameRegistry {
    static let shared = GameRegistry()
    
    private var games: [GameDefinition] = []
    
    private init() {
        registerGames()
    }
    
    private func registerGames() {
        games.append(SampleGameDefinition())
    }
    
    func allGames() -> [GameDefinition] {
        return games
    }
}

