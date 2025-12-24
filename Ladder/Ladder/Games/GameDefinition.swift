//
//  GameDefinition.swift
//  Ladder
//
//  Created by Mason Liebe on 12/23/25.
//

import SwiftUI

protocol GameDefinition {
    var id: String { get }
    var name: String { get }
    var iconName: String { get }
    
    func makeView(mode: GameMode) -> AnyView
    func supportsKeyboard(mode: GameMode) -> Bool
}

