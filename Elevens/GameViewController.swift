//
//  GameViewController.swift
//  Elevens
//
//  Created by Colin on 12/2/15.
//  Copyright © 2015 ccross. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var topLeft: UIImageView!
    @IBOutlet weak var topMiddle: UIImageView!
    @IBOutlet weak var topRight: UIImageView!
    
    @IBOutlet weak var middleLeft: UIImageView!
    @IBOutlet weak var middleMiddle: UIImageView!
    @IBOutlet weak var middleRight: UIImageView!
    
    @IBOutlet weak var bottomLeft: UIImageView!
    @IBOutlet weak var bottomMiddle: UIImageView!
    @IBOutlet weak var bottomRight: UIImageView!
    
    @IBOutlet weak var deckLabel: UILabel!
    
    @IBOutlet weak var totalGamesLabel: UILabel!
    @IBOutlet weak var totalWinsLabel: UILabel!
    
    var board = ElevensBoard()
    var selections : [Bool] = []
    var cardDisplays : [UIImageView!] = []
    
    var totalGames = 0
    var totalWins = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deckLabel.backgroundColor = UIColor(patternImage:  UIImage(named: "back1.png")!)
        
        cardDisplays = [topLeft, topMiddle, topRight, middleLeft, middleMiddle, middleRight, bottomLeft, bottomMiddle, bottomRight]
        
        selections = [Bool](count: board.BOARD_SIZE, repeatedValue: false)
        
        repaint()
        
        if !board.anotherPlayIsPossible() {
            signalLoss()
        }
    }
    
    //sets correct card images to image views so the user can see them
    func repaint() {
        for(var k = 0; k < board.BOARD_SIZE; k++) {
            
            let cardName = imageFileName(board.cardAt(k), isSelected: selections[k])
            let cardImage = UIImage(named: cardName)
            
            if cardImage != nil {
                cardDisplays[k].image = cardImage
            }
            else {
                print("Image does not exist")
            }
            
            deckLabel.text = "\(board.deckSize())"
            totalGamesLabel.text = "\(totalGames)"
            totalWinsLabel.text = "\(totalWins)"
            
            
        }
    }
    
    
    //find the image for the passed card object and whether or not it is selected
    func imageFileName(c : Card?, isSelected : Bool) -> String {
        var str = ""
        
        if(c == nil) {
            return "back1.png"
        }
        
        else {
            
        str += c!.rank + c!.suit
        
        if(isSelected) {
            str += "S"
        }
        
        str += ".png"
        
        return str
        }
    }
    
    
    
    @IBAction func tapPerformed(sender: UITapGestureRecognizer) {
        for(var k = 0; k < board.BOARD_SIZE; k++) {
            if CGRectContainsPoint(cardDisplays[k].frame, sender.locationInView(self.view)) && board.cardAt(k) != nil {
                selections[k] = !selections[k]
                repaint()
                return
            }
        }
    }
    
    
    @IBAction func replaceCards(sender: AnyObject) {
        
        var selection : [Int] = []
        
        
        for(var k = 0; k < board.BOARD_SIZE; k++) {
            if selections[k] {
                selection.append(k)
            }
        }
        
            if !board.isLegal(selection) {
                return
            }
            
            for(var k = 0; k < board.BOARD_SIZE; k++) {
                selections[k] = false
            }
            
            board.replaceSelectedCards(selection)
            
            if board.isEmpty() {
                signalWin()
            }
            else if !board.anotherPlayIsPossible() {
                signalLoss()
            }
        
            repaint()
            
    }
    
    func signalWin() {
        
        totalGames++
        totalWins++
        
        let alert = UIAlertController(title: "WIN", message: "CONGRATULATIONS! You Win!", preferredStyle: UIAlertControllerStyle.Alert)
        let resetButton = UIAlertAction(title: "Reset Game", style: UIAlertActionStyle.Default, handler: {sender in
            self.board.newGame()
            self.repaint()
        
            if !self.board.anotherPlayIsPossible() {
                self.signalLoss()
            }
        })
        
        alert.addAction(resetButton)
        presentViewController(alert, animated: true, completion: nil)

    }
    
    func signalLoss() {
        
        totalGames++
        
        let alert = UIAlertController(title: "No More Moves", message: "SORRY! You lost!", preferredStyle: UIAlertControllerStyle.Alert)
        let resetButton = UIAlertAction(title: "Reset Game", style: UIAlertActionStyle.Default, handler: {sender in
            self.board.newGame()
            self.repaint()
            if !self.board.anotherPlayIsPossible() {
                self.signalLoss()
            }
        })
        
        alert.addAction(resetButton)
        presentViewController(alert, animated: true, completion: nil)

    }
    
    @IBAction func reset(sender: AnyObject) {
        
        for(var k = 0; k < board.BOARD_SIZE; k++) {
            selections[k] = false
        }
        board.newGame()
        
        repaint()
        
        if !board.anotherPlayIsPossible() {
            signalLoss()
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let MVC = segue.destinationViewController as! MenuViewController
        MVC.totalGames = totalGames
        MVC.totalWins = totalWins
    }
    
}
