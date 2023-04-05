//
//  Board.swift
//  ConnectFour
//
//  Created by Abduraxmon on 05/04/23.
//

import Foundation
import UIKit

var board = [[BoardItem]]()
var redScore = 0
var yellowScore = 0

func resetBoard() {
    board.removeAll()
    
    for row in 0...5 {
        var rowArray = [BoardItem]()
        for calumn in 0...6 {
            let indexPath = IndexPath.init(item: calumn, section: row)
            let boardItem = BoardItem(indexPath: indexPath, tile: .Empty)
            rowArray.append(boardItem)
        }
        board.append(rowArray)
    }
}

func getBoardItem(_ indexPath: IndexPath) -> BoardItem {
    return board[indexPath.section][indexPath.item]
}

func getLowestEmptyBorderItem(_ column: Int) -> BoardItem? {
    
    
    for row in (0...5).reversed() {
        let boardItem = board[row][column]
        
        if boardItem.emptyTile() {
            return boardItem
        }
    }
    
    return nil
}

func updateWithBordItems(_ boardItem: BoardItem) {
    if let indexPath = boardItem.indexPath {
        board[indexPath.section][indexPath.item] = boardItem
    }
}

func boardIsFull() -> Bool {
    
    
    for row in board {
        for calumn in row {
            if calumn.emptyTile() {
                return false
            }
        }
    }
    
    return true
}

func victoryAchived() -> Bool {
    return horizontalVictory() || verticalVictory() || dioganalVictory()
}

func horizontalVictory() -> Bool {
    for row in board {
        var consecutive = 0
        for column in row {
            if column.tile == currentTurnTile() {
                consecutive += 1
                if consecutive >= 4 {
                    return true
                }
            } else {
                consecutive = 0
            }
        }
    }
    
    return false
}

func verticalVictory() -> Bool {
    
    for column in 0...board.count {
        if checkVerticalColumn(column) {
            return true
        }
    }
    
    return false
}

func checkVerticalColumn(_ columnToCheck: Int) -> Bool {
    var consecutive = 0
    for row in board {
        if row[columnToCheck].tile == currentTurnTile() {
            consecutive += 1
            if consecutive >= 4 {
                return true
            }
        } else {
            consecutive = 0
        }
    }
    
    return false
}

func dioganalVictory() -> Bool {
    
    for column in 0...board.count {
        if checkDiogaonalColumn(column, true, true) {
            return true
        }
        if checkDiogaonalColumn(column, true, false) {
            return true
        }
        if checkDiogaonalColumn(column, false, true) {
            return true
        }
        if checkDiogaonalColumn(column, false, false) {
            return true
        }
    }
    
    return false
}

func checkDiogaonalColumn(_ columnToCheck: Int, _ moveUp: Bool, _ reversedRows: Bool) -> Bool {
    
    var movingColumn = columnToCheck
    var consecutive = 0
    if reversedRows {
        for row in board.reversed() {
            if movingColumn < row.count && movingColumn >= 0 {
                if row[consecutive].tile == currentTurnTile() {
                    consecutive += 1
                    if consecutive >= 4 {
                        return true
                    }
                } else {
                    consecutive = 0
                }
                movingColumn = moveUp ? movingColumn + 1: movingColumn - 1
            }
        }
    } else {
        for row in board {
            if movingColumn < row.count && movingColumn >= 0 {
                if row[consecutive].tile == currentTurnTile() {
                    consecutive += 1
                    if consecutive >= 4 {
                        return true
                    }
                } else {
                    consecutive = 0
                }
                movingColumn = moveUp ? movingColumn + 1: movingColumn - 1
            }
        }
    }
    
    return false
}
