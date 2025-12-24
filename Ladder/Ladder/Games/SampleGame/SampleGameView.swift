//
//  SampleGameView.swift
//  Ladder
//
//  Created by Mason Liebe on 12/23/25.
//

import SwiftUI

struct SampleGameView: View {
    let mode: GameMode
    
    @State private var grid: SudokuGrid
    @State private var selectedRow: Int? = nil
    @State private var selectedCol: Int? = nil
    
    init(mode: GameMode) {
        self.mode = mode
        _grid = State(initialValue: SudokuGenerator.generatePuzzle(difficulty: 40))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 20)
            
            Text("Sudoku")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            SudokuGridView(
                grid: grid,
                selectedRow: selectedRow,
                selectedCol: selectedCol,
                onCellTapped: { row, col in
                    if !grid.isGiven(at: row, col: col) {
                        selectedRow = row
                        selectedCol = col
                    }
                }
            )
            
            Spacer()
                .frame(height: 20)
            
            NumberPadView(onNumberTapped: { number in
                if let row = selectedRow, let col = selectedCol {
                    if grid.isValid(number, at: row, col: col) || grid.getValue(at: row, col: col) == number {
                        grid.setValue(grid.getValue(at: row, col: col) == number ? nil : number, at: row, col: col)
                    }
                }
            })
            
            Spacer()
        }
        .padding()
    }
}

struct SudokuGridView: View {
    let grid: SudokuGrid
    let selectedRow: Int?
    let selectedCol: Int?
    let onCellTapped: (Int, Int) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<9, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<9, id: \.self) { col in
                        SudokuCellView(
                            value: grid.getValue(at: row, col: col),
                            isGiven: grid.isGiven(at: row, col: col),
                            isSelected: selectedRow == row && selectedCol == col,
                            showTopBorder: row % 3 == 0 && row > 0,
                            showLeftBorder: col % 3 == 0 && col > 0
                        )
                        .onTapGesture {
                            onCellTapped(row, col)
                        }
                    }
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .padding(8)
    }
}

struct SudokuCellView: View {
    let value: Int?
    let isGiven: Bool
    let isSelected: Bool
    let showTopBorder: Bool
    let showLeftBorder: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(isSelected ? Color.blue.opacity(0.2) : Color.clear)
                .border(Color.primary.opacity(0.1), width: 0.5)
            
            if showTopBorder {
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.primary)
                    .offset(y: -1)
            }
            
            if showLeftBorder {
                Rectangle()
                    .frame(width: 2)
                    .foregroundColor(.primary)
                    .offset(x: -1)
            }
            
            if let value = value {
                Text("\(value)")
                    .font(isGiven ? .system(size: 18, weight: .bold) : .system(size: 18, weight: .regular))
                    .foregroundColor(isGiven ? .primary : .blue)
            }
        }
    }
}

struct NumberPadView: View {
    let onNumberTapped: (Int) -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(1...9, id: \.self) { number in
                Button(action: {
                    onNumberTapped(number)
                }) {
                    Text("\(number)")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(width: 44, height: 44)
                        .background(Color(.systemGray5))
                        .foregroundColor(.primary)
                        .cornerRadius(8)
                }
            }
        }
        .padding(.horizontal)
    }
}
