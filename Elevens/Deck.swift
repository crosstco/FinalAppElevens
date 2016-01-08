//
//  Deck.swift
//  Elevens
//
//  Created by Colin on 12/3/15.
//  Copyright © 2015 ccross. All rights reserved.
//

import UIKit

class Deck : NSObject {

    var cards : [Card?]
    var size : Int
    
    //creates a deck of cards
    init(ranks : [String], suits : [String], values : [Int]) {
        
        cards = [Card?](count: suits.count * ranks.count, repeatedValue: nil) //creates an empty array of set size
        
        size = 0 //keeps track of the size and position of the deck when creating it
        var position = 0 //keeps track of the position within the values array when creating it
        
        for suit in suits {
            for rank in ranks {
                cards[size] = Card(cardRank: rank, cardSuit: suit, cardValue: values[position]) //create a card for each rank, suit, and value passed in the parameter. Add it to the deck
                ++size
                ++position
            }
            position = 0
        }

    }
    
    
    func isEmpty() -> Bool { //check if the deck has no cards in it
        return size == 0
    }
    
    
    func deal() -> Card? { //deals a card from the deck
        if isEmpty() {
            return nil
        }
        
        size--
        return cards[size]
    }
    
    
    func shuffle() { //shuffles the deck using a selection shuffle algorithm
                     //(Takes a random card in the deck and swaps it with the end)
        for(var k = cards.count - 1; k > 1; k--) {
            
            let r = Int(arc4random_uniform(UInt32(k)))
            
            let temp = cards[k]
            cards[k] = cards[r]
            cards[r] = temp
        }
        size = cards.count //reset size variable
    }
    
    
}
