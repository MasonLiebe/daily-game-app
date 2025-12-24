//
//  SudokuGrid.swift
//  Ladder
//
//  Created by Mason Liebe on 12/23/25.
//

import Foundation

struct SudokuGrid {
    var cells: [[Int?]]
    var givenCells: Set<GridPosition>
    
    struct GridPosition: Hashable {
        let row: Int
        let col: Int
    }
    
    init() {
        cells = Array(repeating: Array(repeating: nil, count: 9), count: 9)
        givenCells = []
    }
    
    mutating func setValue(_ value: Int?, at row: Int, col: Int) {
        cells[row][col] = value
    }
    
    func getValue(at row: Int, col: Int) -> Int? {
        return cells[row][col]
    }
    
    func isGiven(at row: Int, col: Int) -> Bool {
        return givenCells.contains(GridPosition(row: row, col: col))
    }
    
    func isValid(_ value: Int, at row: Int, col: Int) -> Bool {
        // Check row
        for c in 0..<9 {
            if c != col, let cellValue = cells[row][c], cellValue == value {
                return false
            }
        }
        
        // Check column
        for r in 0..<9 {
            if r != row, let cellValue = cells[r][col], cellValue == value {
                return false
            }
        }
        
        // Check 3x3 box
        let boxRow = (row / 3) * 3
        let boxCol = (col / 3) * 3
        for r in boxRow..<(boxRow + 3) {
            for c in boxCol..<(boxCol + 3) {
                if r != row || c != col {
                    if let cellValue = cells[r][c], cellValue == value {
                        return false
                    }
                }
            }
        }
        
        return true
    }
    
    func isComplete() -> Bool {
        for row in 0..<9 {
            for col in 0..<9 {
                if cells[row][col] == nil {
                    return false
                }
            }
        }
        return true
    }
}

class SudokuGenerator {
    static func generatePuzzle(difficulty: Int = 40) -> SudokuGrid {
        var grid = generateCompleteGrid()
        removeCells(from: &grid, count: difficulty)
        return grid
    }
    
    private static func generateCompleteGrid() -> SudokuGrid {
        var grid = SudokuGrid()
        
        // Fill diagonal 3x3 boxes first (they don't conflict)
        fillBox(&grid, row: 0, col: 0)
        fillBox(&grid, row: 3, col: 3)
        fillBox(&grid, row: 6, col: 6)
        
        // Fill remaining cells using backtracking
        _ = solveGrid(&grid)
        
        return grid
    }
    
    private static func fillBox(_ grid: inout SudokuGrid, row: Int, col: Int) {
        var numbers = Array(1...9).shuffled()
        var index = 0
        
        for r in row..<(row + 3) {
            for c in col..<(col + 3) {
                grid.setValue(numbers[index], at: r, col: c)
                grid.givenCells.insert(SudokuGrid.GridPosition(row: r, col: c))
                index += 1
            }
        }
    }
    
    private static func solveGrid(_ grid: inout SudokuGrid) -> Bool {
        for row in 0..<9 {
            for col in 0..<9 {
                if grid.getValue(at: row, col: col) == nil {
                    for num in 1...9 {
                        if grid.isValid(num, at: row, col: col) {
                            grid.setValue(num, at: row, col: col)
                            if solveGrid(&grid) {
                                return true
                            }
                            grid.setValue(nil, at: row, col: col)
                        }
                    }
                    return false
                }
            }
        }
        return true
    }
    
    private static func removeCells(from grid: inout SudokuGrid, count: Int) {
        var removed = 0
        var positions = (0..<9).flatMap { row in
            (0..<9).map { col in (row, col) }
        }.shuffled()
        
        for (row, col) in positions {
            if removed >= count { break }
            
            let originalValue = grid.getValue(at: row, col: col)
            grid.setValue(nil, at: row, col: col)
            grid.givenCells.remove(SudokuGrid.GridPosition(row: row, col: col))
            
            // Verify puzzle is still solvable
            var testGrid = grid
            if solveGrid(&testGrid) {
                removed += 1
            } else {
                // Restore if removing makes it unsolvable
                grid.setValue(originalValue, at: row, col: col)
                grid.givenCells.insert(SudokuGrid.GridPosition(row: row, col: col))
            }
        }
    }
}

