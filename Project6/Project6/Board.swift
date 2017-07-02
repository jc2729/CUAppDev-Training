//
//  Board.swift
//  FinalProject
//
//  Created by Janice Chan on 5/6/17.
//  Copyright © 2017 Janice Chan. All rights reserved.
//

import UIKit
class Cell{
    let row:Int
    let col:Int
    var mine = false //true, if contains mine
    var number = 0 //neighboring mines
    var revealed = false //true, if has been revealed
    
    //If variable mine is true, the cell holds a mine
    init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
    
}

class Board {
    
    var rows = 8
    var cols = 8
    var board = [[Cell]]()
    var numTotalMines: Int
    var numRevealed = 0
    
    init(rows: Int, cols: Int) {
        
        self.rows = rows
        self.cols = cols
        for row in 0 ..< rows {
            var oneRow:[Cell] = []
            for col in 0 ..< cols {
                let oneCell = Cell(row: row, col: col)
                oneRow.append(oneCell)
            }
            board.append(oneRow)
        }
        numTotalMines = Int(Double(rows * cols) * 0.2)
        generateNewContent()
    }
    
    func generateNewContent(){
        for r in 0 ..< rows {
            for c in 0 ..< cols {
                board[r][c].revealed = false
                board[r][c].mine = false
            }
        }
        addMines()
        updateNeighboringNumbers()
        
        numRevealed = 0
    }
    
    func addMines(){
        for _ in 0 ..< numTotalMines {
            var mineRow: Int
            var mineCol: Int
            mineRow = Int(arc4random_uniform(UInt32(rows)) )
            mineCol = Int(arc4random_uniform(UInt32(cols)) )
            while board[mineRow][mineCol].mine == true {
                mineRow = Int(arc4random_uniform(UInt32(rows)) )
                mineCol = Int(arc4random_uniform(UInt32(cols)) )
            }
            self.board[mineRow][mineCol].mine = true
            
        }
        
    }
    
    func updateNeighboringNumbers() {
        for r in 0 ..< rows {
            for c in 0 ..< cols {
                board[r][c].number = numberOfCellNeigbors(cellRow: r,cellCol: c)
            }
        }
    }
    
    func numberOfCellNeigbors(cellRow: Int, cellCol: Int) -> Int {
        var number = 0
        let delRow=[-1,0,1]
        let delCol=[-1,0,1]
        for row in delRow{
            for col in delCol{
                if (row + cellRow) >= 0 && (row + cellRow) < rows && (col + cellCol)>=0 && (col + cellCol) < cols && board[row + cellRow][col + cellCol].mine == true {
                    number = number + 1
                }
            }
        }
        return number
    }
    
    //for debugging purposes
    func printBoard(){
        for r in 0 ..< rows {
            for c in 0 ..< cols {
                if board[r][c].mine {
                    print(r,c)
                }
                
                
            }
        }
    }
    
    
}
