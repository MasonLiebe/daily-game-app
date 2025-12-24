//
//  GameHeaderView.swift
//  Ladder
//
//  Created by Mason Liebe on 12/23/25.
//

import SwiftUI

struct GameHeaderView: View {
    let gameName: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(gameName)
                .font(.headline)
                .fontWeight(.semibold)
            
            HStack {
                Text("Timer: --:--")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("Score: 0")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
    }
}

