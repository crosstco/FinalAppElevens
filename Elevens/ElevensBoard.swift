
//
//  ElevensBoard.swift
//  Elevens
//
//  Created by Colin on 12/4/15.
//  Copyright © 2015 ccross. All rights reserved.
//

import UIKit

class ElevensBoard: Board { //ElevensBoard is a type of board and therefore inherits from board
    
    //default board size for 11s
    let BOARD_SIZE = 9
    
    //array of card ranks
    let RANKS = ["ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king"]
    
    //array of card suits
    let SUITS = ["spades", "hearts", "diamonds", "clubs"]
    
    //array of card values as used in the game Elevens
    let VALUES = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 0, 0, 0]
    
    
    //creates a board
    init() {
        super.init(size: BOARD_SIZE, ranks: RANKS, suits: SUITS, values: VALUES)
    }
    
    //checks to make sure the selected cards are a legal combination
    func isLegal(selectedCards : [Int]) -> Bool {
        
        if(selectedCards.count == 2) {
            return containsPairSumEleven(selectedCards)
        }
        else if(selectedCards.count == 3) {
            return containsJQK(selectedCards)
        }
        else {
            return false
        }
    }
    
    //scans the entire board for another play and returns whether one exists.
    func anotherPlayIsPossible() -> Bool {
        return containsJQK(cardIndexes()) || containsPairSumEleven(cardIndexes())
    }
    
    //checks to see if the selected cards sum to 11
    func containsPairSumEleven(selectedCards : [Int]) -> Bool {
        for(var o = 0; o < selectedCards.count - 1; o++) {
            for(var i = o + 1; i < selectedCards.count; i++) {
                
                let card1 = cardAt(selectedCards[o])
                let card2 = cardAt(selectedCards[i])
                
                if card1 != nil && card2 != nil && card1!.value + card2!.value == 11{
                        return true
                }
            }
        }
        return false
    }
    
    //chcecks to see if the selected cards contain a jack, queen, and king
    func containsJQK(selectedCards : [Int]) -> Bool {
        var foundJack = false
        var foundQueen = false
        var foundKing = false
        
        for i in selectedCards {
            
            if(cardAt(i) != nil) {
                if(cardAt(i)!.rank == "jack") {
                    foundJack = true
                }
            
                else if(cardAt(i)!.rank == "queen") {
                    foundQueen = true
                }
            
                else if(cardAt(i)!.rank == "king") {
                    foundKing = true
                }
            }
        }
          return foundJack && foundQueen && foundKing
        }
    }