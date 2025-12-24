//
//  SampleGameDefinition.swift
//  Ladder
//
//  Created by Mason Liebe on 12/23/25.
//

import SwiftUI

struct SampleGameDefinition: GameDefinition {
    var id: String { "sample-game" }
    var name: String { "Sudoku" }
    var iconName: String { "square.grid.3x3" }
    
    func makeView(mode: GameMode) -> AnyView {
        AnyView(SampleGameView(mode: mode))
    }
    
    func supportsKeyboard(mode: GameMode) -> Bool {
        return false
    }
}

