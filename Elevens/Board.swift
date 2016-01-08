//
//  Board.swift
//  Elevens
//
//  Created by Colin on 12/3/15.
//  Copyright © 2015 ccross. All rights reserved.
//

import UIKit


class Board {

    //represents the 9 cards on the board
    var cards : [Card?]
    
    //represents the deck of undealt cards
    var deck : Deck
    
    //creates a board of defined size with defined card types
    init(size : Int, ranks : [String], suits : [String], values : [Int]) {
        
        cards = [Card?](count: size, repeatedValue: nil)
        
        deck = Deck(ranks: ranks, suits: suits, values: values)
        
        newGame()
    }
    
    //resets the game
    func newGame() {
        deck.shuffle()
        dealMyCards()
    }
    
    //determines if there are no cards on the board
    func isEmpty() -> Bool {
        for card in cards {
            if card != nil {
                return false
            }
        }
        return true
    }
    
    //draws a card from the deck and puts it on specified position
    func deal(k : Int) {
        cards[k] = deck.deal()
    }
    
    //returns the size of the board's deck
    func deckSize() -> Int {
        return deck.size
    }

    //returns the card at specified position on the board
    func cardAt(k : Int) -> Card? {
        return cards[k]
    }
    
    //replaces the cards on the board specified by an array parameter
    func replaceSelectedCards(selectedCards : [Int]) {
        for k in selectedCards {
            deal(k)
        }
    }
    
    //returns an array of all card indexes on the board
    func cardIndexes() -> [Int] {
        var selected : [Int] = []
        
        for(var k = 0; k < cards.count; k++) {
            if(cards[k] != nil) {
                selected.append(k)
            }
        }
        return selected
    }
    
    //determines if the player won the game
    func gameIsWon() -> Bool {
        if(deck.isEmpty()) {
            for card in cards {
                if card != nil {
                    return false
                }
            }
            return true
        }
        return false
    }
    
    
    //deals 9 cards and positions them on board
    func dealMyCards() {
        for(var k = 0; k < cards.count; k++) {
            cards[k] = deck.deal()
        }
    }
    
    
}
