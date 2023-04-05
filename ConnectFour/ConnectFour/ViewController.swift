//
//  ViewController.swift
//  ConnectFour
//
//  Created by Abduraxmon on 05/04/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var turnImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetBoard()
        setCellWidthHeight()
    }
    
    func setCellWidthHeight() {
        let width = collectionView.frame.size.width / 9
        let height = collectionView.frame.size.height / 6
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func numberOfSections(in cv: UICollectionView) -> Int {
        return board.count
    }
    
    func collectionView(_ cv: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return board[section].count
    }
    
    func collectionView(_ cv: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cv.dequeueReusableCell(withReuseIdentifier: "idCell", for: indexPath) as! BoardCell
        
        let boardItem = getBoardItem(indexPath)
        cell.image.tintColor = boardItem.tileColor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let column = indexPath.item
        
        if var boardItem = getLowestEmptyBorderItem(column) {
            if let cell = collectionView.cellForItem(at: boardItem.indexPath) as? BoardCell {
                cell.image.tintColor = currentTurnColor()
                boardItem.tile = currentTurnTile()
                updateWithBordItems(boardItem)
                
                if boardIsFull() {
                    resultAfter("Draw")
                }
                
                if victoryAchived() {
                    if yellowTurn() {
                        yellowScore += 1
                    }
                    if redTurn() {
                        redScore += 1
                    }
                    
                    resultAfter(currentTurnVictoryMessage())
                }
                
                toggleTurn(turnImage)
            }
        }
    }
    
    func resultAfter(_ title: String) {
        let message = "\nRed: " + String(redScore) + "\n\nYellow: " + String(yellowScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { [self] _ in
            resetBoard()
            self.resetCells()
        }))
        self.present(ac, animated: true)
    }
    
    func resetCells() {
        for cell in collectionView.visibleCells as! [BoardCell] {
            cell.image.tintColor = .white
        }
    }

}

