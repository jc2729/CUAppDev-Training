//
//  ViewController.swift
//  FinalProject
//
//  Created by Janice Chan on 4/26/17.
//  Copyright © 2017 Janice Chan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var collectionView: UICollectionView!
    var boardDisplay: Board!
    var newGame: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boardDisplay = Board(rows: 8, cols: 8)
        boardDisplay.printBoard()

        view.backgroundColor = .white
        
        
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 35, width: view.frame.width, height: view.frame.width) , collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.register(CellButton.self, forCellWithReuseIdentifier: "Reuse")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        
        newGame = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
        newGame.center = CGPoint(x: view.center.x, y: view.frame.height - 50)
        newGame.backgroundColor = UIColor.white
        newGame.setTitleColor(.blue, for: .normal)
        newGame.setTitle("Start New Game", for: UIControlState.normal)
        newGame.addTarget(self, action: #selector(startNewGame), for: .touchUpInside)
        view.addSubview(newGame)
        view.addSubview(collectionView)
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boardDisplay.cols
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return boardDisplay.rows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Reuse", for: indexPath) as! CellButton
        
        let data = boardDisplay.board[indexPath.section][indexPath.item]
        
        if (data.revealed == true && data.mine == true) {
            cell.textLabel.text = "YIKES"
            endGame(won: false)
        }
        else if (data.revealed == true) {
            cell.textLabel.text = String(data.number)
            if (boardDisplay.rows * boardDisplay.cols - boardDisplay.numTotalMines == boardDisplay.numRevealed){
                endGame(won: true)
            }
        }
        else {
            cell.textLabel.text = "?"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let separator: CGFloat = 3
        let itemWidth = CGFloat((view.frame.width - ( separator * CGFloat(boardDisplay.cols+1))) / CGFloat(boardDisplay.cols) )
        
        return CGSize(width: itemWidth, height: itemWidth) //fix height depending on sections
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = boardDisplay.board[indexPath.section][indexPath.item]
        cell.revealed = true
        if (cell.mine == false) {
            boardDisplay.numRevealed += 1
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(1.5, 0, 1.5, 0)
    }
    
    func endGame(won: Bool){
        let alert: UIAlertController
        if (won) {
            alert = UIAlertController(title: "Yay", message: "You won!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok :)", style: UIAlertActionStyle.default, handler: nil))
        }
        else{
            alert = UIAlertController(title: "Yikes", message: "Sorry, you lost", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok :(", style: UIAlertActionStyle.default, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func startNewGame() {
        boardDisplay.generateNewContent()
        collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

